import 'package:health_and_hope/src/models/baseModel/models.dart';

abstract class PromotorRepositoryApi {
  Future<DataValues> promotoresParticipante({required String idParticipante});
  Future<DataValues> registrarPromotorParticipante({required String idParticipante, required String idPromotorParticipante});
  Future<DataValues> eliminarPromotorParticipante({required String idPromotorParticipante});


}