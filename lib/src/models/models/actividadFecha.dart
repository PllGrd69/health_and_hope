import 'dart:convert';

import 'package:health_and_hope/src/models/baseModel/baseModel.dart';

class ActividadFechaModel extends BaseModel {
  ActividadFechaModel({
    this.id,
    this.created,
    this.modified,
    this.actividadFecha,
    this.tarjetaModificacion,
  });

  String? id;
  String? created;
  String? modified;
  String? actividadFecha;
  String? tarjetaModificacion;

  factory ActividadFechaModel.fromJson(String str) => ActividadFechaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ActividadFechaModel.fromMap(Map<String, dynamic> json) => ActividadFechaModel(
    id: json["id"],
    created: json["created"],
    modified: json["modified"],
    actividadFecha: json["actividadFecha"],
    tarjetaModificacion: json["tarjetaModificacion"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "created": created,
    "modified": modified,
    "actividadFecha": actividadFecha,
    "tarjetaModificacion": tarjetaModificacion,
  };
}
