import 'dart:convert';
import 'package:health_and_hope/src/models/baseModel/baseModel.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/actividadUsuario.dart';
import 'package:health_and_hope/src/models/models/tarjetaModificacionModel.dart';


// class ProgresoActividadModel  extends BaseModel {
//   ProgresoActividadModel({
//     this.id,
//     this.fechaHoraHoy,
//     this.fechaInicio,
//     this.fechaFin,
//     this.cantDias,
//     this.diaActividadHoy,
//     this.titulo,
//     this.horaActividadEntrega,
//     this.horaActividadEntregaFin,
//     this.numActividades,
//     this.actividadesCompletadas,
//     this.actividadesNoCompletadas,
//     this.actividadesEnProceso,
//     this.actividadesSinEstado,
//     this.actividadesConEstado,
//     this.actividadesUsuario,
//   });
//
//   String? id;
//   String? fechaHoraHoy;
//   String? fechaInicio;
//   String? fechaFin;
//   int? cantDias;
//   int? diaActividadHoy;
//   String? titulo;
//   String? horaActividadEntrega;
//   String? horaActividadEntregaFin;
//   int? numActividades;
//   int? actividadesCompletadas;
//   int? actividadesNoCompletadas;
//   int? actividadesEnProceso;
//   int? actividadesSinEstado;
//   int? actividadesConEstado;
//   List<ActividadUsuarioModel>? actividadesUsuario;
//   List<ProgresoActividadDiarioModel>? listProgresoActividadDiario;
//
//
//   set setListProgresoActividadDiario(List<ProgresoActividadDiarioModel>? listProgresoActividadDiario){
//     this.listProgresoActividadDiario = listProgresoActividadDiario;
//   }
//
//   List<ProgresoActividadDiarioModel>? get getListProgresoActividadDiario{
//     return this.listProgresoActividadDiario;
//   }
//
//   String get porcentajeAvanzado{
//     try {
//       int porcentaje = (this.actividadesConEstado!*100)~/this.numActividades!;
//       return '${porcentaje}% del progreso';
//     } on IntegerDivisionByZeroException catch (e) {
//       return 'Sin actividades';
//     }
//
//   }
//
//   factory ProgresoActividadModel.fromJson(String str) => ProgresoActividadModel.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory ProgresoActividadModel.fromMap(Map<String, dynamic> json) => ProgresoActividadModel(
//     id: json["id"],
//     fechaHoraHoy: json["fechaHoraHoy"],
//     fechaInicio: json["fechaInicio"],
//     fechaFin: json["fechaFin"],
//     cantDias: json["cantDias"],
//     diaActividadHoy: json["diaActividadHoy"],
//     titulo: json["titulo"],
//     horaActividadEntrega: json["horaActividadEntrega"],
//     horaActividadEntregaFin: json["horaActividadEntregaFin"],
//     numActividades: json["numActividades"],
//     actividadesCompletadas: json["actividadesCompletadas"],
//     actividadesNoCompletadas: json["actividadesNoCompletadas"],
//     actividadesEnProceso: json["actividadesEnProceso"],
//     actividadesSinEstado: json["actividadesSinEstado"],
//     actividadesConEstado: json["actividadesConEstado"],
//     actividadesUsuario: List<ActividadUsuarioModel>.from(json["actividadesUsuario"].map((x) => ActividadUsuarioModel.fromMap(x))),
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "fechaHoraHoy": fechaHoraHoy,
//     "fechaInicio": fechaInicio,
//     "fechaFin": fechaFin,
//     "cantDias": cantDias,
//     "diaActividadHoy": diaActividadHoy,
//     "titulo": titulo,
//     "horaActividadEntrega": horaActividadEntrega,
//     "horaActividadEntregaFin": horaActividadEntregaFin,
//     "numActividades": numActividades,
//     "actividadesCompletadas": actividadesCompletadas,
//     "actividadesNoCompletadas": actividadesNoCompletadas,
//     "actividadesEnProceso": actividadesEnProceso,
//     "actividadesSinEstado": actividadesSinEstado,
//     "actividadesConEstado": actividadesConEstado,
//     "actividadesUsuario": List<dynamic>.from(actividadesUsuario!.map((x) => x.toMap())),
//   };
// }
//

// class ProgresoActividadDiarioModel extends BaseModel {
//   ProgresoActividadDiarioModel({
//     this.tarjetaUsuario,
//     this.actividadHoy,
//     this.cantidadDias,
//     this.actividadesDiarias,
//   });
//
//   TarjetaModificacionModel? tarjetaUsuario;
//   ActividadModel? actividadHoy;
//   int? cantidadDias;
//   List<ActividadModel>? actividadesDiarias;
//
//   factory ProgresoActividadDiarioModel.fromJson(String str) => ProgresoActividadDiarioModel.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory ProgresoActividadDiarioModel.fromMap(Map<String, dynamic> json) => ProgresoActividadDiarioModel(
//     tarjetaUsuario: TarjetaModificacionModel.fromMap(json["tarjetaUsuario"]),
//     actividadHoy: ActividadModel.fromMap(json["actividadHoy"]),
//     cantidadDias: json["cantidadDias"],
//     actividadesDiarias: List<ActividadModel>.from(json["actividadesDiarias"].map((x) => ActividadModel.fromMap(x))),
//   );
//
//   Map<String, dynamic> toMap() => {
//     "tarjetaUsuario": (tarjetaUsuario!=null)? tarjetaUsuario!.toMap(): null,
//     "actividadHoy": (actividadHoy!=null)?actividadHoy!.toMap():null,
//     "cantidadDias": cantidadDias,
//     "actividadesDiarias": (actividadesDiarias!=null)? List<dynamic>.from(actividadesDiarias!.map((x) => x.toMap())):null,
//   };
// }
//
// class ActividadModel {
//   ActividadModel({
//     this.created,
//     this.modified,
//     this.id,
//     this.tarjetaModificacionId,
//     this.actividadFecha,
//     this.totalActividades,
//     this.actividadesEnBlanco,
//     this.actividadesMarcadas,
//     this.actividadesCompletadas,
//     this.actividadesNoCompletadas,
//     this.actividadesEnProceso,
//   });
//
//   String? created;
//   String? modified;
//   String? id;
//   String? tarjetaModificacionId;
//   String? actividadFecha;
//   int? totalActividades;
//   int? actividadesEnBlanco;
//   int? actividadesMarcadas;
//   int? actividadesCompletadas;
//   int? actividadesNoCompletadas;
//   int? actividadesEnProceso;
//
//   factory ActividadModel.fromJson(String str) => ActividadModel.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory ActividadModel.fromMap(Map<String, dynamic> json) => ActividadModel(
//     created: json["created"],
//     modified: json["modified"],
//     id: json["id"],
//     tarjetaModificacionId: json["tarjetaModificacion_id"],
//     actividadFecha: json["actividadFecha"],
//     totalActividades: json["totalActividades"],
//     actividadesEnBlanco: json["actividadesEnBlanco"],
//     actividadesMarcadas: json["actividadesMarcadas"],
//     actividadesCompletadas: json["actividadesCompletadas"],
//     actividadesNoCompletadas: json["actividadesNoCompletadas"],
//     actividadesEnProceso: json["actividadesEnProceso"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "created": created,
//     "modified": modified,
//     "id": id,
//     "tarjetaModificacion_id": tarjetaModificacionId,
//     "actividadFecha": actividadFecha,
//     "totalActividades": totalActividades,
//     "actividadesEnBlanco": actividadesEnBlanco,
//     "actividadesMarcadas": actividadesMarcadas,
//     "actividadesCompletadas": actividadesCompletadas,
//     "actividadesNoCompletadas": actividadesNoCompletadas,
//     "actividadesEnProceso": actividadesEnProceso,
//   };
// }

