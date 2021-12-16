part of 'departamentoBloc.dart';



class DepartamentoState {
  late List<DepartamentoModel>? listDepartamento;
  late Map<dynamic, dynamic>? listDepartamentoError;
  DepartamentoState({this.listDepartamento, this.listDepartamentoError});

  DepartamentoState copyWith({List<DepartamentoModel>? listDepartamento, Map<dynamic, dynamic>? listDepartamentoError}) {
    return DepartamentoState(
      listDepartamento: listDepartamento,
      listDepartamentoError: listDepartamentoError,
    );
  }
  DepartamentoState initState() => DepartamentoState();
}