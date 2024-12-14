import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_bloc/features/auth/domain/entities/app_user.dart';
import 'package:social_media_bloc/features/auth/domain/repos/auth_repo.dart';
import 'package:social_media_bloc/features/auth/presentation/cubits/auth_states.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Cubit<AuthStates> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthBloc({required this.authRepo}) : super(AuthInitial());

  // Check Authentication
  Future<void> checkAuth() async {
    emit(AuthInitial());
    try {
      emit(AuthLoading());
      final AppUser? user = await authRepo.getCurrentUser();

      if (user != null) {
        _currentUser = user;
        emit(AuthSuccess(user: user));
      } else {
        emit(UnAuthState());
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_mapFirebaseError(e)));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Get Current User
  AppUser? get user => _currentUser!;

  // Login
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.login(email, password);
      if (user != null) {
        _currentUser = user;
        emit(AuthSuccess(user: user));
      } else {
        emit(UnAuthState());
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_mapFirebaseError(e)));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Register
  Future<void> register(String email, String password, String name) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.register(email, password, name);
      if (user != null) {
        _currentUser = user;
        emit(AuthSuccess(user: user));
      } else {
        emit(UnAuthState());
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_mapFirebaseError(e)));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      emit(AuthLoading());
      await authRepo.logout();
      _currentUser = null;
      emit(UnAuthState());
    } catch (e) {
      emit(AuthError('Failed to logout. Please try again.'));
    }
  }

  // Helper: Map FirebaseAuthException to User-Friendly Message
  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No user found for this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'This email is already in use. Please use a different email.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return e.message ?? 'Authentication error occurred.';
    }
  }
}
