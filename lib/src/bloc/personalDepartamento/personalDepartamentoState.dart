part of 'personalDepartamentoBloc.dart';


class PersonalDepartamentoState {

  late PersonalDepartamentoPaginadoModel? personalDepartamentoPaginado;
  late Map<dynamic, dynamic>? personalDepartamentoPaginadoError;
  late List<PersonalModel>? listPersonalDepDisponible;
  late Map<dynamic, dynamic>? listPersonalDepDisponibleError;
  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  late PersonalDepartamentoPaginadoModel? personalDeparDisponiblePag;
  late Map<dynamic, dynamic>? personalDeparDisponiblePagError;
  PersonalDepartamentoState({
    this.personalDepartamentoPaginado,
    this.personalDepartamentoPaginadoError,
    this.listPersonalDepDisponible,
    this.listPersonalDepDisponibleError,
    this.personalDeparDisponiblePag,
    this.personalDeparDisponiblePagError
  });

  PersonalDepartamentoState copyWith({
    PersonalDepartamentoPaginadoModel? personalDepartamentoPaginado,
    Map<dynamic, dynamic>? personalDepartamentoPaginadoError,
    List<PersonalModel>? listPersonalDepDisponible,
    Map<dynamic, dynamic>? listPersonalDepDisponibleError,
    PersonalDepartamentoPaginadoModel? personalDeparDisponiblePag,
    Map<dynamic, dynamic>? personalDeparDisponiblePagError,
  }) {
    if (listPersonalDepDisponible!=null) print(listPersonalDepDisponible.length);
    return PersonalDepartamentoState(
      personalDepartamentoPaginado: personalDepartamentoPaginado,
      personalDepartamentoPaginadoError: personalDepartamentoPaginadoError,
      listPersonalDepDisponible: listPersonalDepDisponible,
      listPersonalDepDisponibleError: listPersonalDepDisponibleError,
      personalDeparDisponiblePag:personalDeparDisponiblePag,
      personalDeparDisponiblePagError:personalDeparDisponiblePagError,
    );
  }

  PersonalDepartamentoState initState() => PersonalDepartamentoState();
}