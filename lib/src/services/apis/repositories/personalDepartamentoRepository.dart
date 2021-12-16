import 'package:health_and_hope/src/models/baseModel/models.dart';

abstract class PersonalDepartamentoRepositoryApi {
  Future<DataValues> allPersonalDepartamento({required String uuidDepartamento, required int page});
  Future<DataValues> registrarPersonalDepartamento({required String uuidDepartamento, required String uuidPersonal});
  Future<DataValues> eliminarPersonalDep({required String uuidPersonalDep});
  Future<DataValues> allPersonalDepDisponible({required String idDepartamento});
  Future<DataValues> personalDisponibleParticipante({required String idParticipante, required String dni, required String email, required int page});
}