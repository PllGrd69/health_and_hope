import 'dart:convert';

import 'package:health_and_hope/src/models/baseModel/baseModel.dart';

class ActividadModel  extends BaseModel {

  static String completado   = '0';
  static String noCompletado = '1';
  static String enProceso    = '2';

  ActividadModel({
    this.id,
    this.created,
    this.modified,
    this.titulo,
    this.horaEjecucion,
    this.tarjetaModificacion,
    this.estadoActividad,
    this.departamento,
  });

  String? id;
  String? created;
  String? modified;
  String? titulo;
  String? horaEjecucion;
  String? tarjetaModificacion;
  String? estadoActividad;
  String? departamento;

  factory ActividadModel.fromJson(String str) => ActividadModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ActividadModel.fromMap(Map<String, dynamic> json) => ActividadModel(
    id: json["id"],
    created: json["created"],
    modified: json["modified"],
    titulo: json["titulo"],
    horaEjecucion: json["horaEjecucion"],
    tarjetaModificacion: json["tarjetaModificacion"],
    estadoActividad: json["estadoActividad"],
    departamento: json["departamento"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "created": created,
    "modified": modified,
    "titulo": titulo,
    "horaEjecucion": horaEjecucion,
    "tarjetaModificacion": tarjetaModificacion,
    "estadoActividad": estadoActividad,
    "departamento": departamento,
  };
}
