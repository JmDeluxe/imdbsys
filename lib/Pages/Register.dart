import 'package:flutter/material.dart';
import 'package:registration/timer/confirmAnimation.dart';
import 'package:registration/Pages/login.dart';
import 'package:registration/dbHelper/MongoDBModel.dart';
import 'package:registration/dbHelper/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:lottie/lottie.dart';
import 'package:registration/dbHelper/MongoDBModel.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}


class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool _passwordVisible1 = true;

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final emailAddress = TextEditingController();

  String? passChecker;

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
                  top: -2,
                  left: -40,
                  child: Image.asset('assets/broccoli.png', width: size.height * 0.2,),
                ),
                Positioned(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('REGISTER', style: TextStyle(letterSpacing: 2, fontSize: 30),),
                        Image.asset('assets/cooking.png', width: size.height * 0.35,),
                        Container(
                          padding: EdgeInsets.only(left: 40, right: 40),
                          child:
                          TextFormField(
                            controller: firstName,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 50, top: 35),
                              prefixIcon: Icon(Icons.person, color: Colors.deepOrangeAccent,),
                              labelText: 'First Name',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange,),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                                return '';
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 8,),
                        Container(
                          padding: EdgeInsets.only(left: 40, right: 40),
                          child:
                          TextFormField(
                            controller: lastName,
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              contentPadding: EdgeInsets.only(left: 50, top: 35),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange,),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                                return '';
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 8,),
                        Container(
                          padding: EdgeInsets.only(left: 40, right: 40),
                          child:
                          TextFormField(
                            controller: emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                                contentPadding: EdgeInsets.only(left: 50, top: 35),
                              prefixIcon: Icon(Icons.email, color: Colors.deepOrangeAccent,),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange,),
                                borderRadius: BorderRadius.circular(25.0),
                              )
                            ),
                            validator: (value){
                              if(value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                                return '';
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 8,),
                        Container(
                          padding: EdgeInsets.only(left: 40, right: 40),
                          child:
                          TextFormField(
                            controller: password,

                            obscureText: _passwordVisible,decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: _passwordVisible ? Icon(Icons.visibility, color: Colors.black,) : Icon(Icons.visibility_off, color: Colors.black,),
                              ),
                              labelText: 'Enter password',
                              contentPadding: EdgeInsets.only(left: 50, top: 35),
                              prefixIcon: Icon(Icons.password_outlined, color: Colors.deepOrangeAccent,),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange,),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return '';
                              }else{
                                setState(() {
                                  passChecker = value;
                                });
                              };
                            },
                          ),
                        ),
                        SizedBox(height: 8,),
                        Container(
                          padding: EdgeInsets.only(left: 40, right: 40),
                          child:
                          TextFormField(
                            obscureText: _passwordVisible1,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible1 = !_passwordVisible1;
                                  });
                                },
                                icon: _passwordVisible1 ? Icon(Icons.visibility, color: Colors.black,) : Icon(Icons.visibility_off, color: Colors.black,),
                              ),
                              labelText: 'Confirm Password',
                              contentPadding: EdgeInsets.only(left: 50, top: 35),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange,),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return '';
                              }else if(passChecker != value) {
                                return 'Password not match';
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 8,),
                        Container(
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  colors: [
                                    Colors.deepOrangeAccent,
                                    Colors.orange.withOpacity(0.7),
                                  ]
                              )
                          ),
                          child: TextButton(onPressed: () async {
                            if(formKey.currentState!.validate()){
                              String fname = firstName.text;
                              String lName = lastName.text;
                              String pass = password.text;
                              String email = emailAddress.text;
                              await _insertData(firstName: fname, lastName: lName, email: email, password: pass);

                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return confirm();
                              }));
                            }
                          },
                            child: Text('Confirm',style: TextStyle(color: Colors.white, fontSize: 17),),
                            style: TextButton.styleFrom(padding: EdgeInsets.all(16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Already have an Account?'),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return login();
                                }));
                              },
                                child: Text(' Sign Up', style: TextStyle(fontWeight: FontWeight.bold),),
                            )
                          ],
                        ),
                        SizedBox(height: 50,)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }




  Future<void> _insertData({required String firstName, required String lastName, required String email, required String password})async {
    var _id = M.ObjectId();
    final data = MongoDbModel( id: _id, firstName: firstName, lastName: lastName, email: email, password: password);
    var result = await MongoDB.insert(data);
  }

  // Future createUser({required String firstName, required String lastName, required String email, required String password}) async {
  //
  //   final docUser = FirebaseFirestore.instance.collection('users').doc();
  //
  //   final json = {
  //     'first name': firstName,
  //     'last name': lastName,
  //     'email address': email,
  //     'password': password,
  //   };
  //
  //   await docUser.set(json);
  // }
}
