import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> loginUser({required String email,required String password}) async {
   emit(LoginLoadingState());
   try {
     UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
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
  Future<void> registerUser({required String email,required String password}) async {
    emit(RegisterLoadingState());
    try {
      UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
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
}
