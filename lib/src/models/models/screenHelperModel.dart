import 'dart:convert';

import 'package:health_and_hope/src/models/baseModel/baseModel.dart';

class ScreenHelperModel extends BaseModel {
  ScreenHelperModel({
    this.id,
    this.created,
    this.modified,
    this.titulo,
    this.descripcion,
    this.imagen,
    this.orden,
  });

  String? id;
  String? created;
  String? modified;
  String? titulo;
  String? descripcion;
  String? imagen;
  int? orden;

  factory ScreenHelperModel.fromJson(List<int> str) => ScreenHelperModel.fromMap(json.decode(utf8.decode(str)));

  String toJson() => json.encode(toMap());

  factory ScreenHelperModel.fromMap(Map<String, dynamic> json) => ScreenHelperModel(
    id: json["id"],
    created: json["created"],
    modified: json["modified"],
    titulo: json["titulo"],
    descripcion: json["descripcion"],
    imagen: json["imagen"],
    orden: json["orden"],
  );


  Map<String, dynamic> toMap() => {
    "id": id,
    "created": created,
    "modified": modified,
    "titulo": titulo,
    "descripcion": descripcion,
    "imagen": imagen,
    "orden": orden,
  };
}
