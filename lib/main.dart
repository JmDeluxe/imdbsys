import 'package:flutter/material.dart';
import 'package:registration/Pages/Register.dart';
import 'package:registration/Pages/display.dart';
import 'package:registration/Pages/login.dart';
import 'package:registration/Pages/welcome_screen.dart';
import 'package:registration/dbHelper/mongodb.dart';
import 'package:registration/timer/updateChecker.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDB.connect();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: welcome(),
  ));
}


