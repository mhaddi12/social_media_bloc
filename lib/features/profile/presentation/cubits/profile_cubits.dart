import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_bloc/features/profile/domain/entities/profile_user.dart';
import 'package:social_media_bloc/features/profile/domain/repo/profile_repo.dart';
import 'package:social_media_bloc/features/profile/presentation/cubits/profile_state.dart';

class ProfileCubits extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubits({required this.profileRepo}) : super(ProfileInitial());

  Future<void> getProfile(String uid) async {
    try {
      emit(ProfileLoading());
      final profileUser = await profileRepo.getProfile(uid);
      if (profileUser != null) {
        emit(ProfileLoaded(profileUser: profileUser));
      } else {
        emit(ProfileError(errorMessage: 'Profile not found'));
      }
    } catch (e) {
      emit(ProfileError(
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> updateProfile(
      {required String uid,
      String? newBio,
      String? newPhoto,
      String? newLocation,
      String? newName}) async {
    try {
      emit(ProfileLoading());
      final currentUser = await profileRepo.getProfile(uid);
      if (currentUser != null) {
        final newProfileUser = currentUser.copyWith(
            bio: newBio ?? currentUser.bio,
            photoUrl: newPhoto ?? currentUser.photoUrl,
            location: newLocation ?? currentUser.location,
            name: newName ?? currentUser.name);
        await profileRepo.updateProfile(newProfileUser);
        await getProfile(uid);
        emit(ProfileLoaded(profileUser: newProfileUser));
      } else {
        emit(ProfileError(errorMessage: 'Profile not Updated'));
      }
    } catch (e) {
      emit(ProfileError(errorMessage: e.toString()));
    }
  }
}
