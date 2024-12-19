import 'package:flutter/material.dart';
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
  bool isEditMode = false;

  // Controllers for editable fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profileCubits.getProfile(widget.uid);
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubits, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is ProfileLoaded) {
          // Populate controllers with data
          nameController.text = state.profileUser.name;
          bioController.text = state.profileUser.bio ?? '';
          locationController.text = state.profileUser.location ?? '';

          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              title: Text(
                state.profileUser.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              centerTitle: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              actions: [
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == "Logout") {
                      // Handle logout
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                          value: "Settings", child: Text("Settings")),
                      const PopupMenuItem(
                          value: "Logout", child: Text("Logout")),
                    ];
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Picture Section
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.network(
                              state.profileUser.photoUrl ??
                                  'https://i.pravatar.cc/300',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: FloatingActionButton.small(
                            onPressed: () {
                              // Handle profile photo update
                            },
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: const Icon(Icons.camera_alt,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Editable Name Section
                    _buildEditableField(
                      label: 'Name',
                      controller: nameController,
                      isEditMode: isEditMode,
                      context: context,
                    ),
                    const SizedBox(height: 8),

                    // Editable Bio Section
                    _buildEditableField(
                      label: 'Bio',
                      controller: bioController,
                      isEditMode: isEditMode,
                      maxLines: 3,
                      context: context,
                    ),
                    const SizedBox(height: 16),

                    // Other Editable Details Section
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
                            _buildEditableField(
                              label: 'Location',
                              controller: locationController,
                              isEditMode: isEditMode,
                              context: context,
                            ),
                            const Divider(),
                            _buildProfileDetail(
                              icon: Icons.email,
                              label: 'Email',
                              value: state.profileUser.email!,
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
            floatingActionButton: isEditMode
                ? FloatingActionButton.extended(
                    onPressed: () {
                      // Save changes
                      profileCubits.updateProfile(
                        newBio: bioController.text,
                        newLocation: locationController.text,
                        newPhoto: state.profileUser.photoUrl,
                        newName: nameController.text,
                        uid: widget.uid,
                      );
                      setState(() {
                        isEditMode = false;
                      });
                    },
                    heroTag: 'saveProfileButton', // Assign a unique tag
                    icon: const Icon(Icons.check),
                    label: const Text("Save"),
                  )
                : FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        isEditMode = true;
                      });
                    },
                    tooltip: "Edit Profile",
                    heroTag: 'editProfileButton', // Assign a unique tag
                    child: const Icon(Icons.edit),
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

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required bool isEditMode,
    int maxLines = 1,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
        ),
        const SizedBox(height: 4),
        isEditMode
            ? TextFormField(
                controller: controller,
                maxLines: maxLines,
                decoration: InputDecoration(
                  hintText: 'Enter $label',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
            : Text(
                controller.text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
      ],
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
