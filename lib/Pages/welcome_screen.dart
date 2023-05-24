import 'package:flutter/material.dart';
import 'package:registration/Pages/Component/body.dart';

class welcome extends StatelessWidget {
  const welcome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget> [
          body(),
        ],
      ),
    );
  }
}
