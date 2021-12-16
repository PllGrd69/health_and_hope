part of 'userAppBloc.dart';

@immutable
abstract class UserAppEvent{}

class RegisterUserApp extends UserAppEvent{
  final CreateUserModel userCreated;
  RegisterUserApp({required this.userCreated});
}

class AccessUserApp extends UserAppEvent {
  final AccesUserModel accesUserModel;
  AccessUserApp({required this.accesUserModel});
}

class MyCurrentUserAppEvent extends UserAppEvent {}

class SignOff extends UserAppEvent {}

class UpdateCurrentUserAppEvent extends UserAppEvent {
  final UserModel userModelUpdate;
  UpdateCurrentUserAppEvent({required this.userModelUpdate});
}

class ImagePickerUserAppEvent extends UserAppEvent {
  final String? imagePicker;
  ImagePickerUserAppEvent({this.imagePicker});
}


class SendEmailRestPwdUserAppEvent extends UserAppEvent {
  final String email;
  SendEmailRestPwdUserAppEvent({required this.email});
}


class RestPwdUserAppEvent extends UserAppEvent {
  final String token;
  final String password;
  RestPwdUserAppEvent({required this.token, required this.password});
}
