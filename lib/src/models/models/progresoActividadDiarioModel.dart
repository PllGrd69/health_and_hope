import 'dart:convert';
import 'package:health_and_hope/src/models/baseModel/baseModel.dart';
import 'package:health_and_hope/src/models/models/tarjetaModificacionModel.dart';

class ProgresoActividadDiarioModel extends BaseModel {
  ProgresoActividadDiarioModel({
    this.tarjetaUsuario,
    this.actividadHoy,
    this.cantidadDias,
    this.numDiaHoy,
    this.actividadesDiarias,
  });

  TarjetaModificacionModel? tarjetaUsuario;
  ActividadProgresoModel? actividadHoy;
  int? cantidadDias;
  int? numDiaHoy;
  List<ActividadProgresoModel>? actividadesDiarias;

  factory ProgresoActividadDiarioModel.fromJson(String str) => ProgresoActividadDiarioModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProgresoActividadDiarioModel.fromMap(Map<String, dynamic> json) => ProgresoActividadDiarioModel(
    tarjetaUsuario: TarjetaModificacionModel.fromMap(json["tarjetaUsuario"]),
    actividadHoy: json["actividadHoy"]!=null?ActividadProgresoModel.fromMap(json["actividadHoy"]):ActividadProgresoModel(),
    cantidadDias: json["cantidadDias"],
    numDiaHoy: json["numDiaHoy"],
    actividadesDiarias: List<ActividadProgresoModel>.from(json["actividadesDiarias"].map((x) => ActividadProgresoModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "tarjetaUsuario": (tarjetaUsuario!=null)? tarjetaUsuario!.toMap(): null,
    "actividadHoy": (actividadHoy!=null)?actividadHoy!.toMap():null,
    "cantidadDias": cantidadDias,
    "numDiaHoy": numDiaHoy,
    "actividadesDiarias": (actividadesDiarias!=null)? List<dynamic>.from(actividadesDiarias!.map((x) => x.toMap())):null,
  };
}

class ActividadProgresoModel {
  ActividadProgresoModel({
    this.created,
    this.modified,
    this.id,
    this.tarjetaModificacionId,
    this.actividadFecha,
    this.totalActividades,
    this.actividadesEnBlanco,
    this.actividadesMarcadas,
    this.actividadesCompletadas,
    this.actividadesNoCompletadas,
    this.actividadesEnProceso,
  });

  String? created;
  String? modified;
  String? id;
  String? tarjetaModificacionId;
  String? actividadFecha;
  int? totalActividades;
  int? actividadesEnBlanco;
  int? actividadesMarcadas;
  int? actividadesCompletadas;
  int? actividadesNoCompletadas;
  int? actividadesEnProceso;


  String get porcentajeAvanzado{
    try {
      int porcentaje = (this.actividadesMarcadas!*100)~/this.totalActividades!;
      return '${porcentaje}% del progreso';
    } on IntegerDivisionByZeroException catch (e) {
      return 'Sin actividades';
    }
  }

  factory ActividadProgresoModel.fromJson(String str) => ActividadProgresoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ActividadProgresoModel.fromMap(Map<String, dynamic> json) => ActividadProgresoModel(
    created: json["created"],
    modified: json["modified"],
    id: json["id"],
    tarjetaModificacionId: json["tarjetaModificacion_id"],
    actividadFecha: json["actividadFecha"],
    totalActividades: json["totalActividades"],
    actividadesEnBlanco: json["actividadesEnBlanco"],
    actividadesMarcadas: json["actividadesMarcadas"],
    actividadesCompletadas: json["actividadesCompletadas"],
    actividadesNoCompletadas: json["actividadesNoCompletadas"],
    actividadesEnProceso: json["actividadesEnProceso"],
  );

  Map<String, dynamic> toMap() => {
    "created": created,
    "modified": modified,
    "id": id,
    "tarjetaModificacion_id": tarjetaModificacionId,
    "actividadFecha": actividadFecha,
    "totalActividades": totalActividades,
    "actividadesEnBlanco": actividadesEnBlanco,
    "actividadesMarcadas": actividadesMarcadas,
    "actividadesCompletadas": actividadesCompletadas,
    "actividadesNoCompletadas": actividadesNoCompletadas,
    "actividadesEnProceso": actividadesEnProceso,
  };
}
