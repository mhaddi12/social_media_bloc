import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_bloc/features/auth/domain/entities/app_user.dart';
import 'package:social_media_bloc/features/auth/presentation/cubits/auth_bloc.dart';
import 'package:social_media_bloc/features/profile/presentation/cubits/profile_cubits.dart';
import 'package:social_media_bloc/features/profile/presentation/cubits/profile_state.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final AuthBloc authBloc = context.read<AuthBloc>();
  late final ProfileCubits profileCubits = context.read<ProfileCubits>();

  late AppUser user = authBloc.user!;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileCubits.getProfile(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubits, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Scaffold(
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        if (state is ProfileLoaded) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                user.email,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
              centerTitle: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            body: Container(
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Picture Section
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.network(
                            state.profileUser.photoUrl ??
                                'https://i.pravatar.cc/300',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Name Section
                      Text(
                        state.profileUser.name,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 8),

                      // Bio Section with Design
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        child: Stack(
                          children: [
                            // Background Image
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // Text Overlay on the Image
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.6),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    state.profileUser.bio!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Other Details Section
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildProfileDetail(
                                icon: Icons.email,
                                label: 'Email',
                                value: state.profileUser.email!,
                                context: context,
                              ),
                              const Divider(),
                              _buildProfileDetail(
                                icon: Icons.location_on,
                                label: 'Location',
                                value: state.profileUser.location!,
                                context: context,
                              ),
                              const Divider(),
                              _buildProfileDetail(
                                icon: Icons.perm_identity,
                                label: 'User ID',
                                value: state.profileUser.id!,
                                context: context,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Something went wrong'),
            ),
          );
        }
      },
    );
  }

  Widget _buildProfileDetail({
    required IconData icon,
    required String label,
    required String value,
    required BuildContext context,
  }) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
