import 'package:flutter/material.dart';
import 'package:mobile_client/pages/home.dart';
import 'package:mobile_client/pages/mainscreen.dart';

void main() => runApp(entryPoint);

MaterialApp entryPoint = MaterialApp(initialRoute: '/home', routes: {
  '/home': (context) => Home(),
  '/mainscreen': (context) => MainScreen(),
});
