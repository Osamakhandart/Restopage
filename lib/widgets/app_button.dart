import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resto_page/constant/app_color.dart';
import 'package:resto_page/utils/extension.dart';

class LoginButton extends StatelessWidget {
  final String appTile;
  final VoidCallback onTap;

  const LoginButton({super.key, required this.appTile, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: appColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child:
              appTile.buttonTextStyle400(fontColor: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final double? width;

  const AppButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.color,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: width ?? double.infinity,
      child: CupertinoButton(
          color: color ?? appColor,
          borderRadius: BorderRadius.circular(5),
          onPressed: onTap,
          child:
              text.buttonTextStyle400(fontColor: Colors.white, fontSize: 15)),
    );
  }
}

class AppTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? splashColor;
  final double? width;

  const AppTextButton(
      {super.key,
      required this.title,
      this.width,
      required this.onTap,
      this.textColor,
      this.splashColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
          onPressed: onTap,
          style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => splashColor ?? appColor.withOpacity(0.3)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
          child: title.appTextStyle400(fontColor: textColor)),
    );
  }
}
