part of 'actividadAyudaBloc.dart';


class ActividadAyudaState {
  late List<ActividadAyudaModel>? listActividadesAyuda;
  late Map<dynamic, dynamic>? listActividadesAyudaError;
  ActividadAyudaState({this.listActividadesAyuda, this.listActividadesAyudaError});
  ActividadAyudaState copyWith({List<ActividadAyudaModel>? listActividadesAyuda, Map<dynamic, dynamic>? listActividadesAyudaError}) {
    return ActividadAyudaState(
      listActividadesAyuda: listActividadesAyuda,
      listActividadesAyudaError: listActividadesAyudaError,
    );
  }
  ActividadAyudaState initState() => ActividadAyudaState();
}