
import 'dart:convert';

import 'package:health_and_hope/src/models/baseModel/baseModel.dart';

class TarjetaModificacionModel  extends BaseModel {
  TarjetaModificacionModel({
    this.id,
    this.created,
    this.modified,
    this.titulo,
    this.fechaInicio,
    this.fechaFin,
    this.horaActividadEntrega,
    this.horaActividadEntregaFin,
    this.participante,
  });

  String? id;
  String? created;
  String? modified;
  String? titulo;
  String? fechaInicio;
  String? fechaFin;
  String? horaActividadEntrega;
  String? horaActividadEntregaFin;
  String? participante;

  factory TarjetaModificacionModel.fromJson(String str) => TarjetaModificacionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TarjetaModificacionModel.fromMap(Map<String, dynamic> json) => TarjetaModificacionModel(
    id: json["id"],
    created: json["created"],
    modified: json["modified"],
    titulo: json["titulo"],
    fechaInicio: json["fechaInicio"],
    fechaFin: json["fechaFin"],
    participante: json["participante"],
    horaActividadEntrega: json["horaActividadEntrega"],
    horaActividadEntregaFin: json["horaActividadEntregaFin"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "created": created,
    "modified": modified,
    "titulo": titulo,
    "fechaInicio": fechaInicio,
    "fechaFin": fechaFin,
    "participante": participante,
    "horaActividadEntrega": horaActividadEntrega,
    "horaActividadEntregaFin": horaActividadEntregaFin,
  };
}
