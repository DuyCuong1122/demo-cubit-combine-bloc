import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {
  final bool isAuthenticated;
  AuthState(this.isAuthenticated);
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(false));

  void login() => emit(AuthState(true));
  void logout() => emit(AuthState(false));

  @override 
  void onChange(Change<AuthState> change) {
    log(change.toString());
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    log(error.toString());
    super.onError(error, stackTrace);
  }
}
