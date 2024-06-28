import 'package:firebase_core/firebase_core.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_app/dashboard/repository/dashboard_repository.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/login/repository/login_repository.dart';
import 'package:todo_app/login/ui/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => LoginRepository(),
        ),
        RepositoryProvider(
          create: (context) => DashboardRepository(),
        ),
      ],
      child: GlobalLoaderOverlay(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.grey[300],
            appBarTheme: AppBarTheme(backgroundColor: Colors.grey[300]),
            fontFamily: GoogleFonts.rosarivo().fontFamily,
            // textTheme: TextTheme(
            //   bodyMedium: GoogleFonts.indieFlower(),
            // )
          ),
          home: LoginScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
