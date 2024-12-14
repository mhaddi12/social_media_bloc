import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_bloc/features/profile/domain/entities/profile_user.dart';

import '../domain/repo/profile_repo.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<ProfileUser?> getProfile(String uid) async {
    // TODO: implement getProfile
    try {
      final userDoc = await firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data()!;
        if (userData != null) {
          final profileUser = ProfileUser(
            id: uid,
            email: userData['email'],
            name: userData['name'],
            bio: userData['bio'] ?? '',
            location: userData['location'] ?? '',
            photoUrl: userData['photoUrl'] ?? '',
          );
          return profileUser;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateProfile(ProfileUser profileUser) async {
    // TODO: implement updateProfile
    try {
      await firestore
          .collection('users')
          .doc(profileUser.id)
          .update(profileUser.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
