import 'package:health_and_hope/src/models/baseModel/models.dart';

abstract class DepartamentoRepositoryApi {
  Future<DataValues> allDepartamentos();
  Future<DataValues> crearDepartamento({required String nombre});
}