import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seguro/domain/repositories/auth/auth_repository.dart';
import 'package:seguro/domain/usecases/login_user.dart';
import 'package:seguro/domain/usecases/register_user.dart';

abstract class AuthEvent {}
class LoginRequested extends AuthEvent{
  final String email;
  final String password;

  LoginRequested(this.email, this.password);

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

}