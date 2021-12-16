part of 'userAppBloc.dart';


class UserState {
  late UserModel? userCreated;
  late Map<dynamic, dynamic>? userCreatedError;

  UserState({
    this.userCreated,
    this.userCreatedError,
  });

  UserState copyWith({
    UserModel? userCreated,
    Map<dynamic, dynamic>? userCreatedError,
  }) => UserState(
    userCreatedError: userCreatedError,
    userCreated: userCreated,
  );

  UserState initState()=> UserState();
}