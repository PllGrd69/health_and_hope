part of 'actividadBloc.dart';

@immutable
abstract class ActividadEvent{}

class MisActividadesEvent extends ActividadEvent{
  final String uidTarjetaModif;
  MisActividadesEvent({required this.uidTarjetaModif});
}


class CambiarMiEstadoActividadEvent extends ActividadEvent{
  final String uuidEstado;
  final String uuidActividad;
  CambiarMiEstadoActividadEvent({
    required this.uuidEstado,
    required this.uuidActividad
  });
}