import 'package:flutter/material.dart';

import '../common/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final List<Widget>? actions;
  final Widget? leading;

  const CustomAppBar({
    required this.title,
    this.backgroundColor = AppColors.backgroundColorLight,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: backgroundColor,
      actions: actions,
      leading: leading,
    );
  }

//prefered size
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
