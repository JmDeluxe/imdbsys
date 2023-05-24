import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:registration/Pages/Register.dart';
import 'package:registration/Pages/update.dart';
import 'package:registration/dbHelper/MongoDBModel.dart';
import 'package:registration/dbHelper/mongodb.dart';
import 'package:registration/dbHelper/MongoDBModel.dart';

class display extends StatefulWidget {
  const display({Key? key}) : super(key: key);

  @override
  State<display> createState() => _displayState();
}




class _displayState extends State<display> {
  String? passChecker;

  bool editable = false;
  bool _passwordVisible = false;

  final formKey = GlobalKey<FormState>();

  final id = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final emailAddress = TextEditingController();
  final temp = TextEditingController();

  List<Map<String, dynamic>> _foundusers = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: MongoDB.getData(),
              builder: (context, AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else {
                if(snapshot.hasData){
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: temp,
                          decoration: InputDecoration(
                            label: Text('Search'),suffixIcon: IconButton(
                            onPressed: () async {
                              try {
                                var yes = await MongoDB.getQuery(temp.text);

                                String? first;
                                String? last;
                                String? email;

                                for(var name in yes) {
                                  first = name['firstName'];
                                  last = name['lastName'];
                                  email = name['email'];
                                }

                                if(email == temp.text){
                                  showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      context: context, builder: (BuildContext context){
                                    return SizedBox(
                                        height: 400,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20, right: 20),
                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text('Information', style: TextStyle( fontSize: 20),),
                                                SizedBox(height: 20,),
                                                TextFormField(
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                      labelText: first,
                                                      labelStyle: TextStyle(color: Colors.grey[700]),
                                                      contentPadding: EdgeInsets.only(left: 50, top: 35),
                                                      prefixIcon: Icon(Icons.perm_identity_sharp, color: Colors.deepOrangeAccent,),
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.orange,),
                                                        borderRadius: BorderRadius.circular(25.0),
                                                      )
                                                  ),
                                                ),
                                                TextFormField(
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                      labelText: last,
                                                      labelStyle: TextStyle(color: Colors.grey[700]),
                                                      contentPadding: EdgeInsets.only(left: 50, top: 35),
                                                      prefixIcon: Icon(Icons.perm_identity_sharp, color: Colors.deepOrangeAccent,),
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.orange,),
                                                        borderRadius: BorderRadius.circular(25.0),
                                                      )
                                                  ),
                                                ),
                                                TextFormField(
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                      labelText: email,
                                                      labelStyle: TextStyle(color: Colors.grey[700]),
                                                      contentPadding: EdgeInsets.only(left: 50, top: 35),
                                                      prefixIcon: Icon(Icons.perm_identity_sharp, color: Colors.deepOrangeAccent,),
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.orange,),
                                                        borderRadius: BorderRadius.circular(25.0),
                                                      )
                                                  ),
                                                ),
                                                TextFormField(
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                      labelText: '***',
                                                      labelStyle: TextStyle(color: Colors.grey[700]),
                                                      contentPadding: EdgeInsets.only(left: 50, top: 35),
                                                      prefixIcon: Icon(Icons.perm_identity_sharp, color: Colors.deepOrangeAccent,),
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.orange,),
                                                        borderRadius: BorderRadius.circular(25.0),
                                                      )
                                                  ),
                                                ),
                                              ]
                                          ),
                                        )
                                    );
                                  });
                                }else{

                                }

                              }catch (e){}
                            },
                            icon: Icon(Icons.search),
                          )
                          )
                        ),
                      ),
                   Expanded(
                     child: ListView.builder(
                  itemCount: snapshot.data.length,
                        itemBuilder: (context, index){
                          MongoDbModel data = MongoDbModel.fromJson(snapshot.data[index]);
                          return displayCard(data);
                        }),
                   )
                    ],
                  );
                }else {
                  return Center(
                    child: Text('No data!')
                  );
                }
              }
            },),
      ),

    );
  }

  Widget displayCard(MongoDbModel data) {
    return Card(
      key: ValueKey(data.email),
      child: Column(
        children: <Widget>[
          TextFormField(
            enabled: false,
            decoration: InputDecoration(
                labelText: data.lastName,
                labelStyle: TextStyle(color: Colors.grey[700]),
                contentPadding: EdgeInsets.only(left: 50, top: 35),
                prefixIcon: Icon(Icons.person, color: Colors.deepOrangeAccent,),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(25.0),
                ),

            ),
          ),
          SizedBox(height: 10,),
          TextFormField(
            enabled: false,
            decoration: InputDecoration(
                labelText: data.firstName,
                labelStyle: TextStyle(color: Colors.grey[700]),
                contentPadding: EdgeInsets.only(left: 50, top: 35),
                prefixIcon: Icon(Icons.perm_identity_sharp, color: Colors.deepOrangeAccent,),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange,),
                  borderRadius: BorderRadius.circular(25.0),
                )
            ),
          ),
          TextFormField(
            enabled: false,
            decoration: InputDecoration(
              labelText: data.email,
              labelStyle: TextStyle(color: Colors.grey[700]),
              contentPadding: EdgeInsets.only(left: 50, top: 35),
              prefixIcon: Icon(Icons.email, color: Colors.deepOrangeAccent,),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(25.0),
              ),

            ),
          ),
          SizedBox(height: 10,),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                icon: _passwordVisible ? Icon(Icons.visibility, color: Colors.black,) : Icon(Icons.visibility_off, color: Colors.black,),
              ),
              labelText: _passwordVisible ? data.password : '***',
              contentPadding: EdgeInsets.only(left: 50, top: 35),
              prefixIcon: Icon(Icons.password_outlined, color: Colors.deepOrangeAccent,),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange,),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: 35,
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return update();
                  },settings: RouteSettings(arguments: data)));
                },
              ),
              IconButton(
                iconSize: 35,
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      context: context, builder: (BuildContext context){
                    return SizedBox(

                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Are you sure? 😨 😭 🥺', style: TextStyle( fontSize: 20),),
                            SizedBox(height: 20,),
                            Container(
                              width: 150,
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
                                await MongoDB.delete(data);
                                Navigator.pop(context);
                                setState(() {});
                              },
                                child: Text('Confirm',style: TextStyle(color: Colors.white, fontSize: 17),),
                                style: TextButton.styleFrom(padding: EdgeInsets.all(16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                              ),
                            ),

                          ]
                    )
                    );
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
