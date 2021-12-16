import 'dart:convert';
import 'package:health_and_hope/src/models/baseModel/models.dart';



class AsistentePaginadoModel extends BaseModel {

  AsistentePaginadoModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  String? previous;
  List<AsistenteModel>? results;

  factory AsistentePaginadoModel.fromJson(String str) => AsistentePaginadoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AsistentePaginadoModel.fromMap(Map<String, dynamic> json) => AsistentePaginadoModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<AsistenteModel>.from(json["results"].map((x) => AsistenteModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": (results!=null)? List<dynamic>.from(results!.map((x) => x.toMap())): null,
  };

}




class AsistenteModel extends BaseModel {
  AsistenteModel({
    this.id,
    this.created,
    this.modified,
    this.asistente,
  });

  String? id;
  String? created;
  String? modified;
  UserModel? asistente;

  factory AsistenteModel.fromJson(String str) => AsistenteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AsistenteModel.fromMap(Map<String, dynamic> json) => AsistenteModel(
    id: json["id"],
    created: json["created"],
    modified: json["modified"],
    asistente: UserModel.fromMap(json["asistente"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "created": created,
    "modified": modified,
    "asistente": (asistente!=null)?asistente!.toMap():null,
  };

}
