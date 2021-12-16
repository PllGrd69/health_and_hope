import 'dart:convert';

import 'package:health_and_hope/src/models/baseModel/baseModel.dart';

class ActividadAyudaModel extends BaseModel{

  ActividadAyudaModel({
    this.id,
    this.created,
    this.modified,
    this.titulo,
    this.descripcion,
    this.imagen,
    this.actividad,
  });

  String? id;
  String? created;
  String? modified;
  String? titulo;
  String? descripcion;
  String? imagen;
  String? actividad;

  factory ActividadAyudaModel.fromJson(String str) => ActividadAyudaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ActividadAyudaModel.fromMap(Map<String, dynamic> json) => ActividadAyudaModel(
    id: json["id"],
    created: json["created"],
    modified: json["modified"],
    titulo: json["titulo"],
    descripcion: json["descripcion"],
    imagen: json["imagen"],
    actividad: json["actividad"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "created": created,
    "modified": modified,
    "titulo": titulo,
    "descripcion": descripcion,
    "imagen": imagen,
    "actividad": actividad,
  };

}
