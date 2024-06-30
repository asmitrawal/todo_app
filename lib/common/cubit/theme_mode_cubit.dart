import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/common/my_theme_data.dart';
import 'package:todo_app/common/my_theme_state.dart';

class MyThemeCubit extends Cubit<MyTheme> {
  MyThemeCubit()
      : super(
            MyTheme(themedata: lightMode, icondata: Icons.lightbulb));

  toggleTheme() {
    emit(state.themedata ==
            lightMode
        ? MyTheme(themedata: darkMode, icondata: Icons.nights_stay_rounded)
        : MyTheme(themedata: lightMode, icondata: Icons.lightbulb));
  }
}
