import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRepository {
  Future<Either<String, User>> googleSignIn() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.displayName!.split(" ").join("_").toLowerCase())
          .set({}, SetOptions(merge: true));
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(e.message!);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> SignOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      return Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(e.message!);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
