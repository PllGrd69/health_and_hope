import 'dart:convert';

import 'package:health_and_hope/src/models/baseModel/baseModel.dart';
import 'package:health_and_hope/src/models/models/actividadFecha.dart';
import 'package:health_and_hope/src/models/models/actividadModel.dart';

class ActividadUsuarioModel extends BaseModel {
  ActividadUsuarioModel({
    this.id,
    this.actividadFecha,
    this.actividad,
    this.estadoActividad,
  });

  String? id;
  ActividadFechaModel? actividadFecha;
  ActividadModel? actividad;
  String? estadoActividad;

  factory ActividadUsuarioModel.fromJson(String str) => ActividadUsuarioModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ActividadUsuarioModel.fromMap(Map<String, dynamic> json) => ActividadUsuarioModel(
    id: json["id"],
    actividadFecha: ActividadFechaModel.fromMap(json["actividadFecha"]),
    actividad: ActividadModel.fromMap(json["actividad"]),
    estadoActividad: json["estadoActividad"] == null ? null : json["estadoActividad"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "actividadFecha": (actividadFecha!=null)?actividadFecha!.toMap():null,
    "actividad": (actividad!=null)?actividad!.toMap():null,
    "estadoActividad": estadoActividad == null ? null : estadoActividad,
  };
}



