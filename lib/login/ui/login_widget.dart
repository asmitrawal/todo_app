import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/common/common_state.dart';
import 'package:todo_app/dashboard/ui/dashboard_screen.dart';
import 'package:todo_app/login/cubit/google_sign_in_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<GoogleSignInCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonSuccessState) {
            Navigator.of(context).push(
              PageTransition(
                child: DashboardScreen(),
                type: PageTransitionType.leftToRight,
                duration: Duration(milliseconds: 300),
              ),
            );
          }
          if (state is CommonLoadingState) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
        },
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // color: Colors.white,
                child: Stack(
                  children: [
                    // Logo at the top
                    Container(
                      height: MediaQuery.of(context).size.width * 0.4,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: FittedBox(
                        child: Icon(
                          FontAwesomeIcons.listCheck,
                          color: Theme.of(context).primaryColor,
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),

                    // Text at the bottom right
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Text(
                        'Todos by Narco',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          // color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Container(
                padding: EdgeInsets.all(10),
                // color: Colors.white,
                child: Text(
                  "Welcome to Todos",
                  style: TextStyle(fontSize: 34),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: 50,
                // color: Colors.white,
                child: Text(
                  "Lets get you started",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      context.read<GoogleSignInCubit>().googleSignIn();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadiusDirectional.circular(15)),
                      child: Text(
                        "Login with Google",
                        style: TextStyle(
                          fontSize: 16,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[500],
                        borderRadius: BorderRadiusDirectional.circular(15)),
                    child: Text(
                      "Use Offline Mode",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                // color: Colors.white,
                child: Text(
                  "Nah, I'm going back to scrolling on tiktok",
                  style: TextStyle(
                      fontSize: 12, decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
