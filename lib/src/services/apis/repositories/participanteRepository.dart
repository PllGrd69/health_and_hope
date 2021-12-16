import 'package:health_and_hope/src/models/baseModel/models.dart';

abstract class ParticipanteRepositoryApi {
  Future<DataValues> allParticipantes({required int page, required String email, required String dni});
  Future<DataValues> eliminarParticipante({required String idParticipante});
}