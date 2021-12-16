import 'dart:convert';

import 'package:health_and_hope/src/models/baseModel/baseModel.dart';

class CrearUsuarioModel extends BaseModel {
  CrearUsuarioModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.username,
    this.password,
  });

  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? username;
  String? password;

  factory CrearUsuarioModel.fromJson(String str) => CrearUsuarioModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CrearUsuarioModel.fromMap(Map<String, dynamic> json) => CrearUsuarioModel(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "password": password,
  };
}
