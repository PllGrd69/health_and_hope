import 'package:health_and_hope/src/form_controllers/registroTarjetaModifFormController.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/tarjetaModificacionModel.dart';
import 'package:health_and_hope/src/repositories/refreshTokenAccess.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/tarjetaModificacionApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/repositories/tarjetaModificacionRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/tarjetaModificacionRepository.dart';
import 'package:health_and_hope/src/services/service_pages/notificationService.dart';

class TarjetaModificacionRepository {
  final TarjetaModificacionRepositoryApi _tarjetaModApi  = TarjetaModificacionRepositoryApiIm(TarjetaModificacionApi(Http()));
  final UserRefreshTokenRepository _refreshToken = UserRefreshTokenRepository();


  Future<DataValues> misTarjetasMod() async {
    DataValues values = await _tarjetaModApi.misTarjetasMod();
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _tarjetaModApi.misTarjetasMod();
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    return  values;
  }



  Future<DataValues> tarjetasModifParticipante({required String idParticipante}) async {
    DataValues? values = await _tarjetaModApi.tarjetasModifParticipante(idParticipante: idParticipante);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _tarjetaModApi.tarjetasModifParticipante(idParticipante: idParticipante);
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    return  values;
  }


  Future<DataValues> registrarTarjetaModifParticipante({required TarjetaModificacionModel tarjetaModifParticipante}) async{
    DataValues? values = await _tarjetaModApi.registrarTarjetaModifParticipante(tarjetaModifParticipante: tarjetaModifParticipante);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _tarjetaModApi.registrarTarjetaModifParticipante(tarjetaModifParticipante: tarjetaModifParticipante);
    }
    registroTarjetaModifFormController.errorFormsMapFromApi(values.errorValue);
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    if (values.modelValue!=null){
      NotificationService.showMessageSave(message: 'Tarjeta registrada correctamente', seconds: 3);
      registroTarjetaModifFormController.cleanData();
    }
    return values;
  }

  Future<DataValues> eliminarTarjetaModifParticipante({required String idTarjetaModif}) async{
    DataValues? values = await _tarjetaModApi.eliminarTarjetaModifParticipante(idTarjetaModif: idTarjetaModif);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _tarjetaModApi.eliminarTarjetaModifParticipante(idTarjetaModif: idTarjetaModif);
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    if (values.errorValue!=null){
      NotificationService.showMessageSave(message: 'Tarjeta eliminada correctamente', seconds: 3);
    }
    return values;
  }

  Future<DataValues> actualizarTarjetaModifParticipante({required TarjetaModificacionModel tarjetaModifParticipante}) async{
    DataValues? values = await _tarjetaModApi.actualizarTarjetaModifParticipante(tarjetaModifParticipante: tarjetaModifParticipante);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _tarjetaModApi.actualizarTarjetaModifParticipante(tarjetaModifParticipante: tarjetaModifParticipante);
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    if (values.errorValue==null){
      NotificationService.showMessageSave(message: 'Tarjeta actualizada correctamente', seconds: 3);
    }
    return values;
  }

}