import 'package:flutter/material.dart';
import 'package:uniconnect/utils/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title, required bool showBackArrow, required List<PopupMenuButton<int>> actionWidgets,});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(color: Colors.black,fontSize: 16)),
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.PrimaryColors),
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
