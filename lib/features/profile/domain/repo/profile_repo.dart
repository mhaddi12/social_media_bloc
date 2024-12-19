import 'dart:io';

import 'package:social_media_bloc/features/profile/domain/entities/profile_user.dart';

abstract class ProfileRepo {
  Future<void> updateProfile(ProfileUser profileUser);
  Future<ProfileUser?> getProfile(String uid);
  Future<void> deleteProfile(String uid);
  Future<File?> uploadProfilePhoto(File? file);
  Future<String?> downloadProfilePhoto(String? url);
}
