
import 'package:health_and_hope/src/models/baseModel/models.dart';

abstract class UserRepositoryApi {
  Future<DataValues> crearUsuario(CreateUserModel createUserModel);
}