
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/userApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/userAppApi.dart';
import 'package:health_and_hope/src/services/apis/repositories/userAppRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/userRepository.dart';

class UserRepositoryApiIm implements UserRepositoryApi {
  final UserApi _api;

  UserRepositoryApiIm(this._api);


  @override
  Future<DataValues> crearUsuario(CreateUserModel createUserModel) async {
    return await _api.crearUsuario(createUserModel);
  }

}