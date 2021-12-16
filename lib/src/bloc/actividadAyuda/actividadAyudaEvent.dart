part of 'actividadAyudaBloc.dart';


@immutable
abstract class ActividadAyudaEvent{}

class MisActividadesAyudaEvent extends ActividadAyudaEvent{
  final String uuidActividad;
  MisActividadesAyudaEvent({required this.uuidActividad});
}
