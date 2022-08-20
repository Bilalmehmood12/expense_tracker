import 'package:expense_tracker/ui/splash_screen.dart';
import 'package:flutter/material.dart';

import 'ui/home_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Assessment',
    theme: ThemeData(
        primaryColor: Colors.grey.shade300,
        primaryColorLight: Colors.white,
        primaryColorDark: Colors.grey.shade700),
    home: const SplashScreen(),
  ));
}





