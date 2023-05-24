import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:registration/Pages/display.dart';

class granted extends StatefulWidget {
  const granted({Key? key}) : super(key: key);

  @override
  State<granted> createState() => _grantedState();
}

class _grantedState extends State<granted> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(milliseconds: 3000), ()=> Navigator.push(context, MaterialPageRoute(builder: (context) {return display();}))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.network('https://assets6.lottiefiles.com/private_files/lf30_rklapo5f.json', animate: true),
          ],
        ),
      ),
    );
  }
}
