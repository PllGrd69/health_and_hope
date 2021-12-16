
import 'dart:convert';

import 'package:health_and_hope/src/models/baseModel/baseModel.dart';
import 'package:health_and_hope/src/models/models/userModel.dart';


class PersonalModelPagModel extends BaseModel {
  PersonalModelPagModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  String? previous;
  List<PersonalModel>? results;

  factory PersonalModelPagModel.fromJson(String str) => PersonalModelPagModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonalModelPagModel.fromMap(Map<String, dynamic> json) => PersonalModelPagModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<PersonalModel>.from(json["results"].map((x) => PersonalModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": (results!=null)? List<dynamic>.from(results!.map((x) => x.toMap())):null,
  };
}



class PersonalModel extends BaseModel {
  PersonalModel({
    this.id,
    this.created,
    this.modified,
    this.personal,
  });

  String? id;
  String? created;
  String? modified;
  UserModel? personal;

  factory PersonalModel.fromJson(String str) => PersonalModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonalModel.fromMap(Map<String, dynamic> json) => PersonalModel(
    id: json["id"],
    created: json["created"],
    modified: json["modified"],
    personal: UserModel.fromMap(json["personal"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "created": created,
    "modified": modified,
    "personal": personal,
  };
}