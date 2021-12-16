import 'package:health_and_hope/src/models/baseModel/models.dart';

abstract class PersonalRepositoryApi {
  Future<DataValues> allPersonal();
  Future<DataValues> listaPersonal({required String dni, required String email, required int page});
  Future<DataValues> eliminarPersonal({required String idPersonal});
}