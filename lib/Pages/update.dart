import 'package:flutter/material.dart';
import 'package:registration/dbHelper/MongoDBModel.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

import '../dbHelper/mongodb.dart';
import '../timer/updateChecker.dart';

class update extends StatefulWidget {

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {

  bool _passwordVisible = true;

  final id = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final emailAddress = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    MongoDbModel data = ModalRoute.of(context)!.settings.arguments as MongoDbModel;

    if(data != null) {

      id.text = data.id.toString();
      firstName.text = data.firstName;
      lastName.text = data.lastName;
      emailAddress.text = data.email;
      password.text = data.password;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
            children: <Widget>[
              SizedBox(height: 70,),
              Text('REGISTER', style: TextStyle(letterSpacing: 2, fontSize: 30),),
              SizedBox(height: 10,),
              TextFormField(
                enabled: false,
                controller: id,
                decoration: InputDecoration(
                    labelText: 'ID',
                    contentPadding: EdgeInsets.only(left: 50, top: 35),
                    prefixIcon: Icon(Icons.admin_panel_settings, color: Colors.deepOrangeAccent,),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange,),
                      borderRadius: BorderRadius.circular(25.0),
                    )
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: firstName,
                decoration: InputDecoration(
                    labelText: 'First Name',
                    contentPadding: EdgeInsets.only(left: 50, top: 35),
                    prefixIcon: Icon(Icons.person, color: Colors.deepOrangeAccent,),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange,),
                      borderRadius: BorderRadius.circular(25.0),
                    )
                ),
                validator: (value){
                  if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                    return '';
                  }
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: lastName,
                decoration: InputDecoration(
                    labelText: 'Last Name',
                    contentPadding: EdgeInsets.only(left: 50, top: 35),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange,),
                      borderRadius: BorderRadius.circular(25.0),
                    )
                ),
                validator: (value){
                  if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                    return '';
                  }
                },
              ),
              SizedBox(height: 10,),
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
              SizedBox(height: 10,),
              TextFormField(
                controller: password,
                obscureText: _passwordVisible,
                decoration: InputDecoration(
                    labelText: 'Passowrd',
                    contentPadding: EdgeInsets.only(left: 50, top: 35),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      icon: _passwordVisible ? Icon(Icons.visibility, color: Colors.black,) : Icon(Icons.visibility_off, color: Colors.black,),
                    ),
                    prefixIcon: Icon(Icons.password, color: Colors.deepOrangeAccent,),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange,),
                      borderRadius: BorderRadius.circular(25.0),
                    )
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return '';
                  }
                },
              ),
              SizedBox(height: 10,),
              Container(
                width: 240,
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

                    _updateData(id: data.id, firstName: fname, lastName: lName, email: email, password: pass);
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return updateChecker();
                    }));
                  }
                },
                  child: Text('Confirm',style: TextStyle(color: Colors.white, fontSize: 25),),
                  style: TextButton.styleFrom(padding: EdgeInsets.all(16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                ),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _updateData({required var id, required String firstName, required String lastName, required String email, required String password}) async {
    final updateData = MongoDbModel( id: id, firstName: firstName, lastName: lastName, email: email, password: password);
    await MongoDB.update(updateData);

    //.whenComplete(() => Navigator.pop(context))

  }
}
