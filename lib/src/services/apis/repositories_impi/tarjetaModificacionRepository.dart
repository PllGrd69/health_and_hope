



import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/models/models/tarjetaModificacionModel.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/tarjetaModificacionApi.dart';
import 'package:health_and_hope/src/services/apis/repositories/tarjetaModificacionRepository.dart';

class TarjetaModificacionRepositoryApiIm implements TarjetaModificacionRepositoryApi {
  final TarjetaModificacionApi _api;

  TarjetaModificacionRepositoryApiIm(this._api);

  @override
  Future<DataValues> misTarjetasMod() async {
    return await _api.misTarjetasMod();
  }

  @override
  Future<DataValues> tarjetasModifParticipante({required String idParticipante}) async {
    return await _api.tarjetasModifParticipante(idParticipante: idParticipante);
  }

  @override
  Future<DataValues> registrarTarjetaModifParticipante({required TarjetaModificacionModel tarjetaModifParticipante}) async{
    return await _api.registrarTarjetaModifParticipante(tarjetaModifParticipante: tarjetaModifParticipante);
  }

  @override
  Future<DataValues> eliminarTarjetaModifParticipante({required String idTarjetaModif}) async {
    return await _api.eliminarTarjetaModifParticipante(idTarjetaModif: idTarjetaModif);
  }

  @override
  Future<DataValues> actualizarTarjetaModifParticipante({required TarjetaModificacionModel tarjetaModifParticipante}) async {
    return await _api.actualizarTarjetaModifParticipante(tarjetaModifParticipante: tarjetaModifParticipante);
  }

}