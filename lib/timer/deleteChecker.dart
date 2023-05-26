import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:registration/Pages/display.dart';

class deleteChecker extends StatefulWidget {
  const deleteChecker({Key? key}) : super(key: key);

  @override
  State<deleteChecker> createState() => _deleteCheckerState();
}

class _deleteCheckerState extends State<deleteChecker> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(milliseconds: 1000), ()=> Navigator.push(context, MaterialPageRoute(builder: (context) {return display();}))
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
            Lottie.network('https://assets9.lottiefiles.com/packages/lf20_yelefni1.json', animate: true),
          ],
        ),
      ),

    );
  }
}
