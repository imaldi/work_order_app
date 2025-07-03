import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/router/router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Judul AppBar
  final Widget? leading; // Widget leading (opsional, misalnya tombol back)
  final bool automaticallyImplyLeading; // Kontrol tombol back otomatis
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      // Styling default AppBar
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 2,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Tinggi default AppBar
}