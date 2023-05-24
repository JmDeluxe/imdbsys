import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:registration/Pages/display.dart';

class updateChecker extends StatefulWidget {
  const updateChecker({Key? key}) : super(key: key);

  @override
  State<updateChecker> createState() => _updateCheckerState();
}

class _updateCheckerState extends State<updateChecker> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(milliseconds: 5000), ()=> Navigator.push(context, MaterialPageRoute(builder: (context) {return display();}))
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
            Lottie.network('https://assets1.lottiefiles.com/packages/lf20_xjhwr9wv.json', animate: true),
            Text('Updating 🥳🥳', style: TextStyle(fontSize: 40),),
            Text('hehehe', style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}
