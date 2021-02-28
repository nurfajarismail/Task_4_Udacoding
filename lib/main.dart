import 'package:flutter/material.dart';
import 'package:task_4/beritaPage.dart';

import 'package:task_4/firstPage.dart';
import 'package:task_4/loginPage.dart';
import 'package:task_4/pageHome.dart';
import 'package:task_4/registerPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: PageHomeBerita(),
      home: RegisterPage(),
    );
  }
}
