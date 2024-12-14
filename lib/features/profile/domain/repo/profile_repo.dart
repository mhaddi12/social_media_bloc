import 'package:social_media_bloc/features/profile/domain/entities/profile_user.dart';

abstract class ProfileRepo {
  Future<void> updateProfile(ProfileUser profileUser);
  Future<ProfileUser?> getProfile(String uid);
}
