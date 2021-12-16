import 'dart:convert';
import 'dart:io' as Io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/repositories/userAppRepository.dart';
import 'package:health_and_hope/src/repositories/refreshTokenAccess.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';



part 'userAppEvent.dart';
part 'userAppState.dart';


class UserAppBloc extends Bloc<UserAppEvent, UserAppState> {
  final UserAppRepository _userAppRepository = UserAppRepository();
  UserRefreshTokenRepository _refreshAccessToken = UserRefreshTokenRepository();
  UserAppBloc(): super(UserAppState().initState());

  @override
  Stream<UserAppState> mapEventToState(UserAppEvent event)  async* {
    if (event is AccessUserApp) {
      state.errorsLogin = null;
      try {
        SmartDialog.showLoading();
        DataValues datavaluesAccess = await _userAppRepository.accessUserApp((event).accesUserModel);
        if (datavaluesAccess.modelValue!=null) {
          DataValues datavaluesUser = await _userAppRepository.myUserApp();
          if (datavaluesUser.modelValue!=null) {
            print(datavaluesUser.modelValue);
            yield state.copyWith(
              userAccess: datavaluesUser.modelValue!=null?(datavaluesUser.modelValue as UserModel):null,
              errorsLogin: datavaluesUser.errorValue,
            );
          } else {
            yield state.copyWith(
                errorsLogin: datavaluesAccess.errorValue
            );
          }
        } else {
          yield state.copyWith(
              errorsLogin: datavaluesAccess.errorValue
          );
        }
      } on Exception catch (_) {
        yield state.copyWith();
      } finally {
        SmartDialog.dismiss();
      }
    }
    else if (event is MyCurrentUserAppEvent) {
      SmartDialog.showLoading();
      try{
        DataValues? refreshTokenUser;
        final String accessToken =  await PreferencesUserApp().getAccessToken();
        if (accessToken.isNotEmpty) {
          DataValues datavalue = await _userAppRepository.myUserApp();
          if (datavalue.errorValue != null) {
            refreshTokenUser = await _refreshAccessToken
                .refreshTokenUser(datavalue.errorValue);
            if (refreshTokenUser.modelValue != null) {
              datavalue = await _userAppRepository.myUserApp();
            }
          }
          final errorNewToken = (refreshTokenUser != null) ? refreshTokenUser.errorValue : null;
          yield state.copyWith(
              userAccess: datavalue.modelValue != null ? (datavalue.modelValue as UserModel) : null,
              errorsLogin: datavalue.errorValue ?? errorNewToken
          );
        }
      } on Exception catch (_) {
        yield state.copyWith();
      } finally {
        SmartDialog.dismiss();
      }
    }
    else if (event is SignOff){
      await PreferencesUserApp().setAccessToken("");
      await PreferencesUserApp().setRefreshToken("");
      yield state.copyWith();
    }
    else if (event is UpdateCurrentUserAppEvent) {
      try {
        SmartDialog.showLoading();
        DataValues? refreshTokenUser;
        final String accessToken =  await PreferencesUserApp().getAccessToken();
        // Update token
        if (accessToken.isNotEmpty) {
          final userModel = (event).userModelUpdate;
          if (!state.userAccess!.compareValues(userModel: userModel)) {

            DataValues dataValuesUserUpdate = await _userAppRepository.updateMyUserApp((event).userModelUpdate);
            if (dataValuesUserUpdate.errorValue != null) {
              refreshTokenUser = await _refreshAccessToken.refreshTokenUser(dataValuesUserUpdate.errorValue);
              if (refreshTokenUser.modelValue != null) dataValuesUserUpdate = await _userAppRepository.myUserApp();
            }

            // Fin update token
            final errorValueNew = (refreshTokenUser != null) ? refreshTokenUser.errorValue : null;
            final modelUserValue = dataValuesUserUpdate.modelValue != null? (dataValuesUserUpdate.modelValue as UserModel):null;

            if (dataValuesUserUpdate.statusCode != 400) {
              yield state.copyWith(
                  imagePicker: (state).imagePicker,
                  userAccess: (state).userAccess!.copyWith(
                      userModel: modelUserValue),
                  errorsUpdate: dataValuesUserUpdate.errorValue ?? errorValueNew
              );
            } else {
              final valor = (state).userAccess!.copyWith(
                  userModel: (event).userModelUpdate);

              yield state.copyWith(userAccess: valor,
                  imagePicker: (state).imagePicker,
                  errorsUpdate: dataValuesUserUpdate.errorValue ??
                      errorValueNew);
            }
          }
          if ((state).imagePicker != null) {
            final bytes = Io.File((state).imagePicker!).readAsBytesSync();
            String base64 = base64Encode(bytes);
            DataValues updateMyImageUserApp = await _userAppRepository.updateMyImageUserApp(base64);

            if (updateMyImageUserApp.errorValue != null) {
              refreshTokenUser = await _refreshAccessToken.refreshTokenUser(updateMyImageUserApp.errorValue);
              if (refreshTokenUser.modelValue != null) updateMyImageUserApp = await _userAppRepository.updateMyImageUserApp(base64);
            }

            final errorValueNew = (refreshTokenUser != null) ? refreshTokenUser.errorValue : null;

            if (updateMyImageUserApp.modelValue != null) {
              (state).userAccess!.avatar = (updateMyImageUserApp.modelValue as UserModel).avatar;
              final modelUserValueImage = (state.userAccess is UserModel) ? (state.userAccess as UserModel) : null;
              yield state.copyWith(
                userAccess: modelUserValueImage,
                errorsUpdate: updateMyImageUserApp.errorValue ?? errorValueNew
              );
            }

          }

        } else {
          yield state.copyWith();
        }

      } on Exception catch (_) {
        yield state.copyWith();
      } finally {
        SmartDialog.dismiss();
      }
    }
    else if (event is ImagePickerUserAppEvent) {
      yield state.copyWith(
        userAccess: (state).userAccess,
        imagePicker: (event).imagePicker
      );
    }
    else if (event is SendEmailRestPwdUserAppEvent) {
      try{
        SmartDialog.showLoading();
        final valueSendEmail = await _userAppRepository.sendEmailResetPwd((event).email);
        yield state.copyWith(
          userAccess: (state).userAccess,
          errorsSendEmail: valueSendEmail.errorValue
        );
      } on Exception catch (e) {
        print("Error----envio mensaje");
        print(e);
      } finally {
        SmartDialog.dismiss();
      }
    }
    else if (event is RestPwdUserAppEvent) {
      try{
        SmartDialog.showLoading();
        final valueResetPwd = await _userAppRepository.resetPassword(
          token: (event).token,
          password: (event).password,
        );
        yield state.copyWith(
          errorsResetPwd: valueResetPwd.errorValue,
          resetPwdStatus: valueResetPwd.statusCode
        );
      } on Exception catch (e) {
        print("Error----envio mensaje");
        print(e);
      } finally {
        SmartDialog.dismiss();
      }
    }
  }
}