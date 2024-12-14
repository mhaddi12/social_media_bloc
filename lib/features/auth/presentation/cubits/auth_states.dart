import 'package:social_media_bloc/features/auth/domain/entities/app_user.dart';

abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class AuthLoading extends AuthStates {}

class AuthError extends AuthStates {
  final String message;
  AuthError(this.message);
}

class AuthSuccess extends AuthStates {
  final AppUser user;
  AuthSuccess({required this.user});
}

class UnAuthState extends AuthStates {}

class AuthLogout extends AuthStates {}

class AuthLogoutSuccess extends AuthStates {}

class AuthLogoutError extends AuthStates {
  final String message;
  AuthLogoutError(this.message);
}

class AuthLogoutLoading extends AuthStates {}

class AuthLogoutSuccessLoading extends AuthStates {}

class AuthLogoutErrorLoading extends AuthStates {}
