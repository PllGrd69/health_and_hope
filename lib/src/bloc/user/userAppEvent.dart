part of 'userAppBloc.dart';

@immutable
abstract class UserEvent{}

class UserRegisterEvent extends UserEvent{
  final CreateUserModel userCreated;
  UserRegisterEvent({required this.userCreated});
}