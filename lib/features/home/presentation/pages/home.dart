import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_bloc/features/auth/presentation/cubits/auth_bloc.dart';
import 'package:social_media_bloc/features/home/presentation/components/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void logOut() async {
    if (kDebugMode) {
      print('logout');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 2,
        // actions: [
        //   IconButton(
        //     onPressed: logOut,
        //     icon: const Icon(Icons.logout, color: Colors.white),
        //   )
        // ],
      ),
      drawer: const CustomDrawer(),
      body: const Center(child: Text('Home')),
    );
  }
}
