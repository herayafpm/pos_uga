part of 'authbloc.dart';

@immutable
abstract class AuthBlocEvent {}

class AuthBlocLoginEvent extends AuthBlocEvent {
  final String username;
  final String password;

  AuthBlocLoginEvent(this.username, this.password);
}

class AuthBlocForgotPassEvent extends AuthBlocEvent {
  final String username;
  final String password;

  AuthBlocForgotPassEvent(this.username, this.password);
}
