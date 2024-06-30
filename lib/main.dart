import 'package:firebase_core/firebase_core.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_app/common/cubit/theme_mode_cubit.dart';
import 'package:todo_app/common/my_theme_data.dart';
import 'package:todo_app/common/my_theme_state.dart';
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
      child: BlocProvider(
        create: (context) => MyThemeCubit(),
        child: BlocBuilder<MyThemeCubit, MyTheme>(
          builder: (context, state) {
            return GlobalLoaderOverlay(
              child: MaterialApp(
                title: 'Flutter Demo',
                theme: state.themedata,
                home: LoginScreen(),
                debugShowCheckedModeBanner: false,
              ),
            );
          },
        ),
      ),
    );
  }
}
