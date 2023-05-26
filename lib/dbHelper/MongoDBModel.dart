// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart' as M;

MongoDbModel mongoDbModelFromJson(String str) => MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
  String firstName;
  String lastName;
  String password;
  String email;
  M.ObjectId id;

  MongoDbModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.email,

  });

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    password: json["password"],
    email: json["email"],

  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "password": password,
    "email": email,
  };
}
