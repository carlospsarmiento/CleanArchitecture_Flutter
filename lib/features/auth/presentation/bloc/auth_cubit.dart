import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/core/utils/validators.dart';
import 'package:app_flutter/features/auth/domain/usecase/login_user.dart';
import 'package:app_flutter/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>{

  // UseCases
  final LoginUser _loginUser;

  // Variables
  String? usernameError;
  String? passwordError;

  AuthCubit(this._loginUser):super(AuthInitialState());

  Future<void> login(String username, String password) async{
    emit(AuthLoginLoadingState());
    final result = await _loginUser.call(username, password);

    /*
    result.fold((l){
      emit(AuthLoginFailState(message: "Ocurrió un error en el login"));
    }, (r){
      emit(AuthLoginSuccessState(user: r));
    });
    */
    result.fold(
      (failure) {
        String errorMessage = "Ocurrió un error en el login.";

        if (failure is NetworkFailure) {
          errorMessage = failure.message ?? "No se pudo conectar al servidor.";
        } else if (failure is HttpFailure) {
          errorMessage = failure.message ?? "Error del servidor. Inténtalo más tarde.";
        } else if (failure is ParseFailure) {
          errorMessage = failure.message ?? "Error al procesar los datos.";
        } else if (failure is UnexpectedFailure) {
          errorMessage = failure.message ?? "Ocurrió un error inesperado.";
        }
        emit(AuthLoginFailState(message: errorMessage));
      },
      (user) {
        emit(AuthLoginSuccessState(user: user));
      },
    );
  }

  void validateUsername(String? username) {
    /*
    if (username == null || username.isEmpty) {
      usernameError = 'El usuario no puede estar vacío';
    } else {
      usernameError = null;
    }
    */

    usernameError = Validators.validateEmail(username);
    emit(AuthFieldValidationState(
        usernameError: usernameError,
        passwordError: passwordError));
  }

  void validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      passwordError = 'La contraseña no puede estar vacía';
    } else {
      passwordError = null;
    }
    emit(AuthFieldValidationState(
        usernameError: usernameError,
        passwordError: passwordError));
  }
}