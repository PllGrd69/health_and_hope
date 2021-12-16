
import 'dart:convert';

import 'package:health_and_hope/src/models/baseModel/baseModel.dart';

class DepartamentoModel extends BaseModel {
  DepartamentoModel({
    this.id,
    this.created,
    this.modified,
    this.nombre,
  });

  String? id;
  String? created;
  String? modified;
  String? nombre;

  factory DepartamentoModel.fromJson(String str) => DepartamentoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DepartamentoModel.fromMap(Map<String, dynamic> json) => DepartamentoModel(
    id: json["id"],
    created: json["created"],
    modified: json["modified"],
    nombre: json["nombre"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "created": created,
    "modified": modified,
    "nombre": nombre,
  };
}
