import 'dart:convert';

import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/asistenteModel.dart';

class ParticipantePaginadoModel extends BaseModel  {
  ParticipantePaginadoModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  String? previous;
  List<ParticipanteModel>? results;

  factory ParticipantePaginadoModel.fromJson(String str) => ParticipantePaginadoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ParticipantePaginadoModel.fromMap(Map<String, dynamic> json) => ParticipantePaginadoModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<ParticipanteModel>.from(json["results"].map((x) => ParticipanteModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": (results!=null)? List<dynamic>.from(results!.map((x) => x.toMap())) : null,
  };
}

class ParticipanteModel extends BaseModel  {
  ParticipanteModel({
    this.id,
    this.created,
    this.modified,
    this.participante,
    this.asistente,
  });

  String? id;
  String? created;
  String? modified;
  UserModel? participante;
  List<AsistenteModel>? asistente;

  factory ParticipanteModel.fromJson(String str) => ParticipanteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ParticipanteModel.fromMap(Map<String, dynamic> json) => ParticipanteModel(
    id: json["id"],
    created: json["created"],
    modified: json["modified"],
    participante: UserModel.fromMap(json["participante"]),
    asistente: List<AsistenteModel>.from(json["asistente"].map((x) => AsistenteModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "created": created,
    "modified": modified,
    "participante": (participante!=null)? participante!.toMap():null,
    "asistente": (asistente!=null)? List<dynamic>.from(asistente!.map((x) => x.toMap())):null,
  };

}

