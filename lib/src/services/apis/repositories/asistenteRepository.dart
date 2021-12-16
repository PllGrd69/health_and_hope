import 'package:health_and_hope/src/models/baseModel/models.dart';

abstract class AsistenteRepositoryApi {
  Future<DataValues> asistentesParticipante({required String idParticipante});
  Future<DataValues> asistentesDisponiblesParticipante({required String idParticipante, required String email, required String dni, required int page});
  Future<DataValues> registrarAsistenteParticipante({required String idParticipante, required String idAsistente});
  Future<DataValues> eliminarAsistenteParticipante({required String idParticipante, required String idAsistente});
  Future<DataValues> todosAsistentes({required String email, required String dni, required int page});
  Future<DataValues> eliminarAsistente({required String idAsistente});
}