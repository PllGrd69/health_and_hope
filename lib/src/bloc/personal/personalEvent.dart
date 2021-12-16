part of 'personalBloc.dart';

@immutable
abstract class PersonalEvent{}

class AllPersonalEvent extends PersonalEvent{}


class ListaPersonalEvent extends PersonalEvent{
  final String dni;
  final String email;
  ListaPersonalEvent({required this.dni, required this.email});
}

class ListaPersonalPagEvent extends PersonalEvent{
  final String dni;
  final String email;
  final int page;
  ListaPersonalPagEvent({required this.dni, required this.email, required this.page});
}

class EliminarPersonalPagEvent extends PersonalEvent{
  final String idPersonal;
  EliminarPersonalPagEvent({required  this.idPersonal});
}


