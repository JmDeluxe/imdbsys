
import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:registration/Pages/login.dart';
import 'package:registration/dbHelper/MongoDBModel.dart';
import 'const.dart';

class MongoDB{
  static var db, userCollection;

  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    var status = db.serverStatus();
    userCollection = db.collection(USER);
  }

  static Future<List<Map<String,dynamic>>> getData() async {
    final listData = await userCollection.find().toList(); 
    return listData;
  }

  static Future<List<Map<String,dynamic>>> getQuery(String search) async {
    final listData = await userCollection.find(where.eq('email', search)).toList();
    return listData;
  }


  static Future<void> update(MongoDbModel data) async {

    await userCollection.update(where.eq('_id', data.id),
      modify.set('firstName', data.firstName,),);

    await userCollection.update(where.eq('_id', data.id),
      modify.set('lastName', data.lastName,),);

    await userCollection.update(where.eq('_id', data.id),
      modify.set('email', data.email,),);

    await userCollection.update(where.eq('_id', data.id),
      modify.set('password', data.password,),);

    // var result = await userCollection.findOne({'_id': data.id});
    // result['firstName'] = data.firstName;
    // // result['lastName'] = data.lastName;
    // // result['password'] = data.password;
    // // result['email'] = data.email;
    // var response = await userCollection.update(result);

  }

  static Future<bool> login(String email, String password) async{
    try{
      var result = await userCollection.findOne({'email': email});
      if (result['email'] == email && result['password'] == password){
        return true;
      }else {
        return false;
      }
    } catch(e){
      return false;
    }
  }


  static Future<String> insert(MongoDbModel data) async{
    try{
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess){
        return 'Data is inserted';
      }else {
        return 'Something wrong';
      }
    } catch(e){
      print(e.toString());
      return e.toString();
    }
  }
    //{id: 1231, firstName: "234234"}
  static delete(MongoDbModel user) async {
    await userCollection.remove(where.id(user.id));
  }
}