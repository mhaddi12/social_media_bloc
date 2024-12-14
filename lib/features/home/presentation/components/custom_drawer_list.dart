import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDrawerList extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  const CustomDrawerList(
      {super.key, required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title.toString()),
      onTap: onTap,
    );
  }
}
