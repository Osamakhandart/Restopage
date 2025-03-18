import 'package:flutter/material.dart';
import 'package:resto_page/constant/app_color.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  Widget? leadingIcon;
  Widget? titleIcon;
  final List<Widget>? action;
  double? appBarHeight;
  Color? appBarColor;
  ShapeBorder? shapeBorder;
  PreferredSizeWidget? bottom;
  double? toolBarHeight;

  /// you can add more fields that meet your needs

  AppAppBar({
    Key? key,
    this.titleText,
    this.action,
    this.leadingIcon,
    this.titleIcon,
    this.appBarHeight,
    this.appBarColor,
    this.shapeBorder,
    this.bottom,
    this.toolBarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleIcon ??
          Text(titleText ?? "",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 15)),
      backgroundColor: appBarColor ?? appColor,
      actions: action,
      shape: shapeBorder,
      toolbarHeight: toolBarHeight,
      iconTheme: const IconThemeData(color: Colors.white),
      leading: leadingIcon,
      elevation: 0,
      centerTitle: true,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? 60);
}
