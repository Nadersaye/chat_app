part of 'authen_bloc.dart';

abstract class AuthenState {}

class AuthenInitial extends AuthenState {}
class LoginLoadingState extends AuthenState { }

class LoginSuccessState extends AuthenState  { }

class LoginFailureState extends AuthenState  { 
  String message;
  LoginFailureState({required this.message});
}

class RegisterLoadingState extends AuthenState  { }

class RegisterSuccessState extends AuthenState  { }

class RegisterFailureState extends AuthenState  { 
  String message;
  RegisterFailureState({required this.message});
}