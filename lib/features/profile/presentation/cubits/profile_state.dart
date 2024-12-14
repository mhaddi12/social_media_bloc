import 'package:social_media_bloc/features/profile/domain/entities/profile_user.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileError extends ProfileState {
  final String errorMessage;
  ProfileError({required this.errorMessage});
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileUser profileUser;
  ProfileLoaded({required this.profileUser});
}
