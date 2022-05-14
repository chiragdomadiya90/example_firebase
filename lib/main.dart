import 'package:example_firebase/view/country.dart';
import 'package:example_firebase/view/home_screen.dart';
import 'package:example_firebase/view/register_screen.dart';
import 'package:example_firebase/view/signin_screen.dart';
import 'package:example_firebase/view/spalash_scr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterScreen(),
    );
  }
}
