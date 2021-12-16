part of 'screensCustomHelperBloc.dart';


class ScreenCustomHelperState {
  late List<ScreenHelperModel>? listScreenHelper;
  late Map<dynamic, dynamic>? listScreenHelperError;

  ScreenCustomHelperState({this.listScreenHelper, this.listScreenHelperError});

  ScreenCustomHelperState copyWith({List<ScreenHelperModel>? listScreenHelper,String? hola, Map<dynamic, dynamic>? listScreenHelperError}) {
    return ScreenCustomHelperState(
      listScreenHelper: listScreenHelper,
      listScreenHelperError: listScreenHelperError,
    );
  }
  ScreenCustomHelperState initState() => ScreenCustomHelperState();
}