import 'package:flutter/material.dart';

extension SizedExtension on double {
  addHSpace() {
    return SizedBox(height: this);
  }

  addWSpace() {
    return SizedBox(width: this);
  }
}

extension AppDivider on double {
  Widget appDivider({Color? color}) {
    return Divider(
      thickness: this,
      color: color ?? Colors.white,
    );
  }
}

extension AppValidation on String {
  isValidEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

int formatDayToInt(String weekday) {
  switch (weekday) {
    case "Monday":
      return 0;
    case "Tuesday":
      return 1;
    case "Wednesday":
      return 2;
    case "Thursday":
      return 3;
    case "Friday":
      return 4;
    case "Saturday":
      return 5;
    case "Sunday":
      return 6;
    default:
      return 0;
  }
}

String getDayOfWeek(int weekday) {
  switch (weekday) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
    default:
      return '';
  }
}

hideKeyBoard(BuildContext context) {
  return FocusScope.of(context).unfocus();
}

printData({required dynamic tittle, dynamic val}) {
  debugPrint(tittle + ":-" + val.toString());
}

extension PoppinsText on String {
  Widget appTextStyle400(
      {Color? fontColor,
      double? fontSize,
      weight = FontWeight.w400,
      TextDecoration? textDecoration,
      TextOverflow? textOverflow,
      isItalic = false,
      TextAlign? textAlign}) {
    return Text(
      this,
      overflow: textOverflow,
      style: TextStyle(
        color: fontColor,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontSize: fontSize ?? 16,
        fontWeight: weight,
        decoration: textDecoration ?? TextDecoration.none,
      ),
      textAlign: textAlign,
    );
  }

  Text appTextStyle500(
      {Color? fontColor,
      double? fontSize,
      TextDecoration? textDecoration,
      TextOverflow? textOverflow,
      TextAlign? textAlign}) {
    return Text(
      this,
      overflow: textOverflow,
      style: TextStyle(
        color: fontColor,
        fontSize: fontSize ?? 16,
        fontWeight: FontWeight.w500,
        decoration: textDecoration ?? TextDecoration.none,
      ),
      textAlign: textAlign,
    );
  }

  Text appTextStyle600(
      {Color? fontColor,
      double? fontSize,
      TextDecoration? textDecoration,
      TextOverflow? textOverflow,
      TextAlign? textAlign}) {
    return Text(
      this,
      overflow: textOverflow,
      style: TextStyle(
        color: fontColor,
        fontSize: fontSize ?? 16,
        fontWeight: FontWeight.w500,
        decoration: textDecoration ?? TextDecoration.none,
      ),
      textAlign: textAlign,
    );
  }
}

extension AppButtonText on String {
  Text buttonTextStyle400(
      {Color? fontColor,
      double? fontSize,
      TextDecoration? textDecoration,
      TextOverflow? textOverflow,
      TextAlign? textAlign}) {
    return Text(
      this,
      overflow: textOverflow,
      style: TextStyle(
        color: fontColor,
        fontSize: fontSize ?? 16,
        fontWeight: FontWeight.w400,
        decoration: textDecoration ?? TextDecoration.none,
      ),
      textAlign: textAlign,
    );
  }
}
