import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_bloc/features/profile/domain/entities/profile_user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../domain/repo/profile_repo.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance.ref();
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

  @override
  Future<void> deleteProfile(String uid) {
    // TODO: implement deleteProfile
    throw UnimplementedError();
  }

  @override
 Future<String?> downloadProfilePhoto(String? filePath) async {
  // Ensure the file path is valid
  if (filePath == null || filePath.isEmpty) {
    print('Invalid file path.');
    return null;
  }

  try {
    // Reference to the file in Firebase Storage
    final ref = FirebaseStorage.instance.ref(filePath);

    // Get the download URL
    final downloadUrl = await ref.getDownloadURL();

    print('Download URL: $downloadUrl');
    return downloadUrl;
  } catch (e) {
    print('Failed to fetch download URL: $e');
    return null;
  }
}

  

  @override
  Future<File?> uploadProfilePhoto(File? file) async {
    // Validate the file
    if (file == null ||
        !file.existsSync() ||
        file.lengthSync() == 0 ||
        file.lengthSync() > 2000000) {
      print('Invalid file. Please upload a valid .jpg or .png file under 1MB.');
      return null; // Return null for invalid files
    }

    try {
      // Extract file name from the path
      final fileName = file.path.split('/').last;
      final imagesRef = storage.child('images/$fileName');

      // Upload the file
      await imagesRef.putFile(file);

      print('File uploaded successfully: $fileName');
      return file;
    } catch (e) {
      print('Failed to upload the file: $e');
      return null; // Return null on failure
    }
  }
}
