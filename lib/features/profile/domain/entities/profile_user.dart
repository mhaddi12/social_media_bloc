import 'package:social_media_bloc/features/auth/domain/entities/app_user.dart';

class ProfileUser extends AppUser {
  final String? bio;
  final String? location;
  final String? photoUrl;

  ProfileUser({
    required super.id,
    required super.email,
    required super.name,
    this.bio,
    this.location,
    this.photoUrl,
  });

  ProfileUser copyWith({
    String? id,
    String? email,
    String? name,
    String? bio,
    String? location,
    String? photoUrl,
  }) =>
      ProfileUser(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        bio: bio ?? this.bio,
        location: location ?? this.location,
        photoUrl: photoUrl ?? this.photoUrl,
      );

  factory ProfileUser.fromJson(Map<String, dynamic> json) => ProfileUser(
        id: json['id'],
        email: json['email'],
        name: json['name'],
        bio: json['bio'] ?? '',
        location: json['location'] ?? '',
        photoUrl: json['photoUrl'] ?? '',
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'bio': bio,
        'photoUrl': photoUrl,
      };

  @override
  String toString() {
    return 'ProfileUser{id: $id, email: $email, name: $name, bio: $bio, location: $location, photoUrl: $photoUrl}';
  }
}
