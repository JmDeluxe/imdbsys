import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:registration/Pages/login.dart';

class confirm extends StatefulWidget {
  const confirm({Key? key}) : super(key: key);

  @override
  State<confirm> createState() => _confirmState();
}

class _confirmState extends State<confirm> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(milliseconds: 2500), ()=> Navigator.push(context, MaterialPageRoute(builder: (context) {return login();}))
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
            Lottie.network('https://assets1.lottiefiles.com/packages/lf20_2mm5zqab.json', animate: true),
            Text('Registered', style: TextStyle(fontSize: 50),)
          ],
        ),
      ),
    );
  }
}
