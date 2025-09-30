import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final double leadingWidth;
  final String? title;
  final TextStyle? titleStyle;
  final Color backgroundColor;
  final List<Widget>? actions;
  final bool centerTitle;
  final double elevation;

  const CustomAppBar({
    super.key,
    this.leading,
    this.leadingWidth = 56.0,
    this.title,
    this.titleStyle,
    this.backgroundColor = Colors.blue,
    this.actions,
    this.centerTitle = false,
    this.elevation = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: leading,
      leadingWidth: leadingWidth,
      title: title != null
          ? Text(
        title!,
        style: titleStyle ??
            const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
      )
          : null,
      centerTitle: centerTitle,
      elevation: elevation,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
