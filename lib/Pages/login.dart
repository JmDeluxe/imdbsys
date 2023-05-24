import 'dart:math';

import 'package:flutter/material.dart';
import 'package:registration/Pages/display.dart';
import 'package:registration/timer/loginGranted.dart';

import '../dbHelper/mongodb.dart';
import 'Register.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool _passwordVisible = true;
  bool checker = false;

  final password = TextEditingController();
  final emailAddress = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: double.infinity,
          child: Form(
            key: formKey,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  right: -25,
                  top: -60,
                  child: Image.asset('assets/magicpattern-blob-1684655783631.png',
                  width: size.height * 0.2,),
                ),
                Positioned(
                  left: -19,
                  bottom: -22,
                  child: Image.asset('assets/cherries.png',
                    width: size.height * 0.2,),
                ),
                Positioned(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('LOGIN', style: TextStyle(letterSpacing: 2, fontSize: 30),),
                      SizedBox(height: 10,),
                      Image.asset('assets/log-in.png', height: size.height * 0.4,),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextFormField(
                          controller: emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email, color: Colors.deepOrangeAccent,),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange,),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          validator: (value){
                            if(checker || value!.isEmpty){
                              return '';
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextFormField(
                          controller: password,
                          obscureText: _passwordVisible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                              icon: _passwordVisible ? Icon(Icons.visibility, color: Colors.black,) : Icon(Icons.visibility_off, color: Colors.black,),
                            ),
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.password_sharp, color: Colors.deepOrangeAccent,),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange,),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          validator: (value){
                            if(checker || value!.isEmpty){
                              return 'Email or Password not found!';
                            }
                          },
                        ),
                      ),SizedBox(height: 15,),
                      Container(
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                colors: [
                                  Colors.orange.withOpacity(0.7),
                                  Colors.deepOrangeAccent,
                                ]
                            )
                        ),
                        child: TextButton(onPressed: () async {
                          //Future<bool> isFirst = await MongoDB.search(emailAddress.text, password.text);
                          if(formKey.currentState!.validate()){

                          }
                          if(await MongoDB.login(emailAddress.text, password.text)){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return granted();
                            }));
                          }else{
                            print(checker);
                            setState(() {
                              checker = true;
                            });
                            // Navigator.push(context, MaterialPageRoute(builder: (context) {
                            //   return login();
                            // }));
                          }
                        },
                          child: Text('Login',style: TextStyle(color: Colors.white, fontSize: 17),),
                          style: TextButton.styleFrom(padding: EdgeInsets.all(16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Dont have account?'),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Register();
                              }));
                            },
                              child: Text(' Register here', style: TextStyle(fontWeight: FontWeight.bold),))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
