import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/screenHelperApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/repositories/screenHelperRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/screenHelperRepository.dart';
import 'package:health_and_hope/src/services/service_apis/screensCustomHelperServiceApi.dart';
import 'package:health_and_hope/src/services/service_pages/notificationService.dart';

class ScreensAppCustomRepository {
  final ScreenHelperRepositoryApi screenHelperApi  = ScreenHelperRepositoryApiIm(ScreenHelperApi(Http()));

  ScreensAppCustomHelperServiceApi helperScreenServiceApi = ScreensAppCustomHelperServiceApi();

  Future<DataValues> allScreensHelper() async {
    final values = await screenHelperApi.allScreensHelper();
    if (values!.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) {
      NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    }
    return  values;
  }

}