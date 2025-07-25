import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seguro/domain/repositories/auth_repository.dart';
import 'package:seguro/domain/usecases/auth/login_user.dart';

import '../../domain/usecases/auth/register_user.dart';

abstract class AuthEvent {}
class LoginRequested extends AuthEvent{
  final String email;
  final String password;
  LoginRequested(this.email, this.password);
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;

  RegisterRequested(this.email, this.password, this.name);

}

abstract class AuthState{}
class AuthInitial extends AuthState{}
class AuthLoading extends AuthState{}
class AuthSuccess extends AuthState{}
class AuthFailure extends AuthState{
  final String error;

  AuthFailure(this.error);

}
class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final LoginUser loginUser;
  final RegisterUser registerUser;

  AuthBloc({required this.loginUser, required this.registerUser}): super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await loginUser(event.email, event.password);
      emit(AuthSuccess());
    }catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onRegisterRequested(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try{
      await registerUser(event.email, event.password, event.name);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

}