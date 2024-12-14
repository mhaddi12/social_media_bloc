import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_bloc/features/auth/domain/entities/app_user.dart';
import 'package:social_media_bloc/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Future<AppUser?> getCurrentUser() async {
    // TODO: implement getCurrentUser
    final user = firebaseAuth.currentUser;
    if (user == null) {
      return null;
    }
    return AppUser(id: user.uid, email: user.email!, name: '');
  }

  @override
  Future<AppUser> login(String email, String password) async {
    // TODO: implement login
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final user =
          AppUser(id: userCredential.user!.uid, email: email, name: '');

      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> logout() async {
    // TODO: implement logout
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser> register(String email, String password, String name) async {
    // TODO: implement register
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user =
          AppUser(id: userCredential.user!.uid, email: email, name: name);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .set(user.toJson());

      return user;
    } catch (e) {
      throw Exception(e);
    }
  }
}
