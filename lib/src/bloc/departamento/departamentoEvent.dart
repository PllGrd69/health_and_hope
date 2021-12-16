part of 'departamentoBloc.dart';


@immutable
abstract class DepartamentoEvent{}

class AllDepartamentos extends DepartamentoEvent{}


class CrearDepartamentoEvent extends DepartamentoEvent{
  final String nombre;
  CrearDepartamentoEvent({required this.nombre});

}
