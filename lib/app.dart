import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_bloc/features/auth/data/firebase_auth_repo.dart';
import 'package:social_media_bloc/features/auth/presentation/cubits/auth_bloc.dart';
import 'package:social_media_bloc/features/auth/presentation/cubits/auth_states.dart';
import 'package:social_media_bloc/features/auth/presentation/pages/auth_page.dart';
import 'package:social_media_bloc/features/home/presentation/pages/home.dart';
import 'package:social_media_bloc/features/profile/data/firebase_profile_repo.dart';
import 'package:social_media_bloc/features/profile/presentation/cubits/profile_cubits.dart';
import 'package:social_media_bloc/themes/dark_mode.dart';
import 'features/profile/domain/repo/profile_repo.dart';
import 'themes/light_mode.dart';

class MyApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();
  final profileRepo = FirebaseProfileRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepo: authRepo)..checkAuth(),
        ),
        BlocProvider<ProfileCubits>(
          create: (context) => ProfileCubits(
            profileRepo: profileRepo,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Social Media',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: BlocListener<AuthBloc, AuthStates>(
          listener: (context, state) {
            if (state is AuthError) {
              // Ensure there's a Scaffold ancestor before showing the SnackBar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Builder(
            builder: (context) {
              return BlocBuilder<AuthBloc, AuthStates>(
                builder: (context, state) {
                  if (state is AuthSuccess) {
                    return const HomePage();
                  } else if (state is UnAuthState) {
                    return const AuthPage();
                  } else if (state is AuthError) {
                    return const AuthPage();
                  }
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
