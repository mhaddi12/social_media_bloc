import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_bloc/features/auth/domain/entities/app_user.dart';
import 'package:social_media_bloc/features/auth/presentation/cubits/auth_bloc.dart';
import 'package:social_media_bloc/features/home/presentation/components/custom_drawer_list.dart';
import 'package:social_media_bloc/features/profile/presentation/cubits/profile_cubits.dart';
import 'package:social_media_bloc/features/profile/presentation/cubits/profile_state.dart';
import 'package:social_media_bloc/features/profile/presentation/pages/profile.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late final AuthBloc authBloc = context.read<AuthBloc>();
  late final ProfileCubits profileCubits = context.read<ProfileCubits>();

  late AppUser user = authBloc.user!;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileCubits.getProfile(user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.background,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              BlocBuilder<ProfileCubits, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProfileLoaded) {
                    return CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueAccent,
                      radius: 70,
                      backgroundImage:
                          NetworkImage(state.profileUser.photoUrl!),
                    );
                  } else {
                    return const Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blueAccent,
                        radius: 70,
                        backgroundImage:
                            NetworkImage('https://i.pravatar.cc/300'),
                      ),
                    );
                  }
                },
              ),

              const Divider(),
              // Add more drawer items as needed
              CustomDrawerList(
                  title: 'H O M E',
                  icon: Icons.home,
                  onTap: () => Navigator.of(context).pop()),
              CustomDrawerList(
                  title: 'P R O F I L E',
                  icon: Icons.person,
                  onTap: () {
                    Navigator.of(context).pop();
                    final user = context.read<AuthBloc>().user;
                    String? uid = user?.id;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfilePage(
                              uid: uid!,
                            )));
                  }),
              CustomDrawerList(
                  title: 'S E A R C H',
                  icon: Icons.search,
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
              CustomDrawerList(
                  title: 'S E T T I N G S', icon: Icons.settings, onTap: () {}),
              const Spacer(),
              CustomDrawerList(
                  title: 'L O G O U T',
                  icon: Icons.logout,
                  onTap: () async {
                    await BlocProvider.of<AuthBloc>(context).logout();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
