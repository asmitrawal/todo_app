import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/dashboard/ui/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey[300]),
        fontFamily: GoogleFonts.rosarivo().fontFamily,
        // textTheme: TextTheme(
        //   bodyMedium: GoogleFonts.indieFlower(),
        // )
      ),
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
