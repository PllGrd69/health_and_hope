import 'dart:convert';

import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/personalModel.dart';

class PersonalDepartamentoPaginadoModel extends BaseModel {
  PersonalDepartamentoPaginadoModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  String? previous;
  List<ResultPersonalDepartamentoModel>? results;

  factory PersonalDepartamentoPaginadoModel.fromJson(String str) => PersonalDepartamentoPaginadoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonalDepartamentoPaginadoModel.fromMap(Map<String, dynamic> json) => PersonalDepartamentoPaginadoModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<ResultPersonalDepartamentoModel>.from(json["results"].map((x) => ResultPersonalDepartamentoModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": (results!=null)?List<dynamic>.from(results!.map((x) => x.toMap())) : null,
  };
}

class ResultPersonalDepartamentoModel  extends BaseModel  {
  ResultPersonalDepartamentoModel({
    this.id,
    this.created,
    this.modified,
    this.personalDepartamento,
    this.departamento,
  });

  String? id;
  String? created;
  String? modified;
  PersonalModel? personalDepartamento;
  DepartamentoModel? departamento;

  factory ResultPersonalDepartamentoModel.fromJson(String str) => ResultPersonalDepartamentoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResultPersonalDepartamentoModel.fromMap(Map<String, dynamic> json) => ResultPersonalDepartamentoModel(
    id: json["id"],
    created: json["created"],
    modified: json["modified"],
    personalDepartamento: PersonalModel.fromMap(json["personalDepartamento"]),
    departamento: DepartamentoModel.fromMap(json["departamento"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "created": created,
    "modified": modified,
    "personalDepartamento": (personalDepartamento!=null)? personalDepartamento!.toMap(): null,
    "departamento": (departamento!=null)?departamento!.toMap(): null,
  };
}
