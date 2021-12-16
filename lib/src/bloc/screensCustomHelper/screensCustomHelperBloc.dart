import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/repositories/screensCustomHelperRepository.dart';

part 'screensCustomHelperEvent.dart';
part 'screensCustomHelperState.dart';

class ScreenCustomHelperBloc extends Bloc<ScreenCustomHelperEvent, ScreenCustomHelperState> {
  final ScreensAppCustomRepository screensCustomRepository = ScreensAppCustomRepository();

  ScreenCustomHelperBloc(): super(ScreenCustomHelperState().initState());

  @override
  Stream<ScreenCustomHelperState> mapEventToState(ScreenCustomHelperEvent event) async* {
    if (event is AllScreensHelperEvent){
      try {
        DataValues datavalues = await screensCustomRepository.allScreensHelper();
        yield state.copyWith(
          listScreenHelper: datavalues.modelValueList!=null?
          (datavalues.modelValueList as List<ScreenHelperModel>):null,
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      }
    }
  }

}