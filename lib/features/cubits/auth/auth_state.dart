part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}
class LoginLoadingState extends AuthState { }

class LoginSuccessState extends AuthState { }

class LoginFailureState extends AuthState { 
  String message;
  LoginFailureState({required this.message});
}

class RegisterLoadingState extends AuthState { }

class RegisterSuccessState extends AuthState { }

class RegisterFailureState extends AuthState { 
  String message;
  RegisterFailureState({required this.message});
}