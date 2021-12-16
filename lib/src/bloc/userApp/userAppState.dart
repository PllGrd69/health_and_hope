part of 'userAppBloc.dart';


class UserAppState {
  late UserModel? userCreated;
  late UserModel? userAccess;
  late Map<dynamic, dynamic>? errorsCreate;
  late Map<dynamic, dynamic>? errorsLogin;
  late Map<dynamic, dynamic>? errorsUpdate;
  late Map<dynamic, dynamic>? errorsSendEmail;
  late Map<dynamic, dynamic>? errorsResetPwd;
  late int? resetPwdStatus;
  late String? imagePicker;

  UserAppState({
    this.imagePicker,
    this.userCreated,
    this.userAccess,
    this.errorsCreate,
    this.errorsLogin,
    this.errorsUpdate,
    this.errorsSendEmail,
    this.errorsResetPwd,
    this.resetPwdStatus,
  });

  UserAppState copyWith({
    UserModel? userCreated,
    UserModel? userAccess,
    Map<dynamic, dynamic>? errorsCreate,
    Map<dynamic, dynamic>? errorsLogin,
    Map<dynamic, dynamic>? errorsUpdate,
    Map<dynamic, dynamic>? errorsSendEmail,
    Map<dynamic, dynamic>? errorsResetPwd,
    String? imagePicker,
    int? resetPwdStatus,
  }) => UserAppState(
    errorsCreate: errorsCreate,
    errorsLogin: errorsLogin,
    userCreated: userCreated,
    userAccess: userAccess,
    errorsUpdate: errorsUpdate,
    imagePicker: imagePicker,
    errorsSendEmail : errorsSendEmail,
    errorsResetPwd: errorsResetPwd,
    resetPwdStatus: resetPwdStatus,
  );


  UserAppState initState()=> UserAppState();
}