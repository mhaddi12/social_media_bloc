import 'package:flutter/material.dart';
import 'package:social_media_bloc/features/auth/presentation/pages/sign_up.dart';

import 'login.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showTogglePage = true;
  void togglePage() => setState(() => showTogglePage = !showTogglePage);
  @override
  Widget build(BuildContext context) {
    if (showTogglePage) {
      return Login(
        togglePage: togglePage,
      );
    } else {
      return Register(
        togglePage: togglePage,
      );
    }
  }
}
