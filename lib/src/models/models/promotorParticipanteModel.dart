import 'dart:convert';
import 'package:health_and_hope/src/models/baseModel/models.dart';

class PromotorParticipanteModel extends BaseModel {
  PromotorParticipanteModel({
    this.id,
    this.created,
    this.modified,
    this.promotorParticipante,
    this.participante,
  });

  String? id;
  String? created;
  String? modified;
  ResultPersonalDepartamentoModel? promotorParticipante;
  ParticipanteModel? participante;

  factory PromotorParticipanteModel.fromJson(String str) => PromotorParticipanteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PromotorParticipanteModel.fromMap(Map<String, dynamic> json) => PromotorParticipanteModel(
    id: json["id"],
    created: json["created"],
    modified: json["modified"],
    promotorParticipante: ResultPersonalDepartamentoModel.fromMap(json["promotorParticipante"]),
    participante: ParticipanteModel.fromMap(json["participante"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "created": created,
    "modified": modified,
    "promotorParticipante": promotorParticipante,
    "participante": (participante!=null)? participante!.toMap():null,
  };

}
