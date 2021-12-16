part of 'personalBloc.dart';


class PersonalState {

  late List<PersonalModel>? listPersonal;
  late Map<dynamic, dynamic>? listPersonalError;
  late PersonalModelPagModel? listPersonalPag;
  late Map<dynamic, dynamic>? listPersonalPagError;

  PersonalState({
    this.listPersonal,
    this.listPersonalError,
    this.listPersonalPag,
    this.listPersonalPagError
  });

  PersonalState copyWith({
    List<PersonalModel>? listPersonal,
    Map<dynamic, dynamic>? listPersonalError,
    PersonalModelPagModel? listPersonalPag,
    Map<dynamic, dynamic>? listPersonalPagError,
  }) => PersonalState(
    listPersonal: listPersonal,
    listPersonalError: listPersonalError,
    listPersonalPag: listPersonalPag,
    listPersonalPagError: listPersonalPagError
  );

  PersonalState initState()=> PersonalState();
}