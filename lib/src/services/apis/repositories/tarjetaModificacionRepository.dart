
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/tarjetaModificacionModel.dart';

abstract class TarjetaModificacionRepositoryApi {
  Future<DataValues> misTarjetasMod();
  Future<DataValues> tarjetasModifParticipante({required String idParticipante});
  Future<DataValues> registrarTarjetaModifParticipante({required TarjetaModificacionModel tarjetaModifParticipante});
  Future<DataValues> eliminarTarjetaModifParticipante({required String idTarjetaModif});
  Future<DataValues> actualizarTarjetaModifParticipante({required TarjetaModificacionModel tarjetaModifParticipante});
}