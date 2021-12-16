import 'package:health_and_hope/src/models/baseModel/baseModel.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';

class DataValues {
  List<ScreenHelperModel>? listScreenHelper;
  Map<dynamic, dynamic>? errorValue;
  int? statusCode = 0;
  BaseModel? modelValue;
  List<BaseModel>? modelValueList;
  DataValues({this.modelValue, this.errorValue, this.statusCode, this.modelValueList});
}