part of 'actividadBloc.dart';

class ActividadState {
  late List<ActividadUsuarioModel>? listActividadesHoy;
  late Map<dynamic, dynamic>? listActividadesHoyError;
  ActividadState({this.listActividadesHoy, this.listActividadesHoyError});
  ActividadState copyWith({List<ActividadUsuarioModel>? listActividadesHoy, Map<dynamic, dynamic>? listActividadesHoyError}) {
    return ActividadState(
      listActividadesHoy: listActividadesHoy,
      listActividadesHoyError: listActividadesHoyError,
    );
  }
  ActividadState initState() => ActividadState();
}