import 'dart:convert';

import 'package:health_and_hope/src/models/baseModel/baseModel.dart';


class AccesUserModel extends BaseModel{
  AccesUserModel({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory AccesUserModel.fromJson(List<int> str) => AccesUserModel.fromMap(json.decode(utf8.decode(str)));

  String toJson() => json.encode(toMap());

  factory AccesUserModel.fromMap(Map<String, dynamic> json) => AccesUserModel(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "password": password,
  };
}

class AccessUserTokenModel extends BaseModel {
  AccessUserTokenModel({
    required this.refresh,
    required this.access,
  });

  String refresh;
  String access;

  factory AccessUserTokenModel.fromJson(List<int> str) => AccessUserTokenModel.fromMap(json.decode(utf8.decode(str)));

  String toJson() => json.encode(toMap());

  factory AccessUserTokenModel.fromMap(Map<String, dynamic> json) => AccessUserTokenModel(
    refresh: json["refresh"]??'',
    access: json["access"]??'',
  );

  Map<String, dynamic> toMap() => {
    "refresh": refresh,
    "access": access,
  };
}

class RefreshTokenModel extends BaseModel {
  RefreshTokenModel({
     this.access,
  });

  String? access;

  factory RefreshTokenModel.fromJson(String str) => RefreshTokenModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RefreshTokenModel.fromMap(Map<String, dynamic> json) => RefreshTokenModel(
    access: json["access"],
  );

  Map<String, dynamic> toMap() => {
    "access": access,
  };
}
