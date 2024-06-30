import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/common/cubit/theme_mode_cubit.dart';
import 'package:todo_app/common/my_theme_state.dart';
import 'package:todo_app/login/cubit/sign_out_cubit.dart';

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
    User? user = FirebaseAuth.instance.currentUser;

    return BlocBuilder<MyThemeCubit, MyTheme>(
      builder: (context, state) {
        return AppBar(
          leading: Container(
            margin: EdgeInsets.only(left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 32,
                  height: 32,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      user!.photoURL!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<MyThemeCubit>().toggleTheme();
                },
                icon: Icon(
                  state.icondata,
                  size: 24,
                )),
            IconButton(
              onPressed: () {
                context.read<SignOutCubit>().signOut();
              },
              icon: Icon(
                Icons.logout,
                size: 24,
              ),
            ),
          ],
          elevation: 0,
          scrolledUnderElevation: 0,
        );
      },
    );
  }
}
