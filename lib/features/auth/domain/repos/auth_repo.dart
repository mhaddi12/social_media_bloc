import 'package:social_media_bloc/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser> login(
    String email,
    String password,
  );
  Future<AppUser> register(String email, String password, String name);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}
