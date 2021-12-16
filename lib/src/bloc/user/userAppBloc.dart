import 'dart:convert';
import 'dart:io' as Io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/repositories/userAppRepository.dart';
import 'package:health_and_hope/src/repositories/refreshTokenAccess.dart';
import 'package:health_and_hope/src/repositories/userRepository.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';



part 'userAppEvent.dart';
part 'userAppState.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userAppRepository = UserRepository();
  UserBloc(): super(UserState().initState());

  @override
  Stream<UserState> mapEventToState(UserEvent event)  async* {
    if (event is UserRegisterEvent){
      try {
        SmartDialog.showLoading(widget: Center(child: CircularProgressIndicator()));
        DataValues datavalues = await _userAppRepository.crearUsuario((event).userCreated);
        if (datavalues.errorValue==null){
          yield state.copyWith(
            userCreated: datavalues.modelValue!=null?(datavalues.modelValue as UserModel):null,
            userCreatedError: datavalues.errorValue,
          );
        } else {
          yield state.copyWith(
            userCreatedError: datavalues.errorValue,
          );
        }
      } on Exception catch (_) {
        yield state.copyWith();
      } finally {
        SmartDialog.dismiss();
      }
    }
  }
}