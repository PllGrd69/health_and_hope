import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/screenHelperApi.dart';
import 'package:health_and_hope/src/services/apis/repositories/screenHelperRepository.dart';

class ScreenHelperRepositoryApiIm implements ScreenHelperRepositoryApi{
  final ScreenHelperApi _api;

  ScreenHelperRepositoryApiIm(this._api);

  @override
  Future<DataValues?> allScreensHelper() {
    return _api.allScreensHelper();
  }

}