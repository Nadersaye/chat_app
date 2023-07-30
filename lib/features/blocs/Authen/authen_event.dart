part of 'authen_bloc.dart';

abstract class AuthenEvent {}
class LoginUser extends AuthenEvent{
  final String email;
  final String  password;
  LoginUser({required this.email, required this.password});
}
class RegisterUser extends AuthenEvent {
  final String email;
  final String  password;
  RegisterUser({required this.email, required this.password});
}