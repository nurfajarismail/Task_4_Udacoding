import 'package:flutter/material.dart';
import 'package:task_4/ui_loginreg/splashPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: PageHomeBerita(),
      // home: RegisterPage(),
      //home: TampilanAwal(),
      home: SplashPage(),
      ////home: WelcomePage(),
    );
  }
}
