import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authen_event.dart';
part 'authen_state.dart';

class AuthenBloc extends Bloc<AuthenEvent, AuthenState> {
  AuthenBloc() : super(AuthenInitial()) {
    void onTransition(Transition <AuthenBloc,AuthenState> transition)
    {
      print(transition);
    }
    onChange(Change <AuthenBloc> change)
    {
      print(change);
    }
    on<AuthenEvent>((event, emit) async {
      if (event is LoginUser) {
        try {
     UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: event.email, password: event.password);
     emit(LoginSuccessState());
   }on FirebaseAuthException catch (ex) {
     if (ex.code == 'user-not-found') {
      emit(LoginFailureState(message: 'user not found'));
     } else if (ex.code == 'wrong-password') {
      emit(LoginFailureState(message: 'wrong-password'));
     }
     } catch (e) {
     emit(LoginFailureState(message: 'there was an error'));
   }
      }
      else if (event is RegisterUser)
      {
        emit(RegisterLoadingState());
    try {
      UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: event.email, password: event.password);
      emit(RegisterSuccessState());
    }on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(LoginFailureState(message: 'weak password'));
       } else if (ex.code == 'email-already-in-use') {
       emit(LoginFailureState(message: 'email-already-in-use'));
       }
       }  catch (e) {
      emit(LoginFailureState(message: 'there was an error'));
    }
      }
    });
  }
  
}
