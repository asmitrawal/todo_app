import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/common/common_state.dart';
import 'package:todo_app/login/cubit/sign_out_cubit.dart';
import 'package:todo_app/login/ui/login_screen.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    IconData _mode = Icons.dark_mode_outlined;
    User? user = FirebaseAuth.instance.currentUser;

    return AppBar(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: Icon(FontAwesomeIcons.user),
      ),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                if (_mode == Icons.dark_mode_outlined) {
                  _mode = Icons.dark_mode;
                } else {
                  _mode = Icons.dark_mode_outlined;
                }
              });
            },
            icon: Icon(_mode)),
        IconButton(
          onPressed: () {
            context.read<SignOutCubit>().signOut();
          },
          icon: Icon(Icons.logout),
        ),
      ],
      elevation: 0,
      scrolledUnderElevation: 0,
    );
  }
}

//

// IconData _mode = Icons.dark_mode_outlined;
// User? user = FirebaseAuth.instance.currentUser;

// AppBar customappBar = AppBar(
//   leading: ClipRRect(
//     borderRadius: BorderRadius.circular(60),
//     child: Icon(FontAwesomeIcons.user),
//   ),
//   actions: [
//     IconButton(
//         onPressed: () {
//           setState(() {
//             if (_mode == Icons.dark_mode_outlined) {
//               _mode = Icons.dark_mode;
//             } else {
//               _mode = Icons.dark_mode_outlined;
//             }
//           });
//         },
//         icon: Icon(_mode)),
//     IconButton(
//       onPressed: () {
//         context.read<SignOutCubit>().signOut();
//       },
//       icon: Icon(Icons.logout),
//     ),
//   ],
//   elevation: 0,
//   scrolledUnderElevation: 0,
// );
