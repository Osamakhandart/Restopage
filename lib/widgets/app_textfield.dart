import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resto_page/constant/app_color.dart';
import 'package:resto_page/utils/extension.dart';

class LoginTextField extends StatelessWidget {
  final String hintText;
  final String titleText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const LoginTextField(
      {super.key,
      this.keyboardType,
      this.hintText = "",
      this.titleText = "",
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText.appTextStyle400(fontColor: Colors.white, fontSize: 12),
        5.0.addHSpace(),
        Container(
          height: 50,
          decoration: BoxDecoration(
              color: texFieldColor, borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: TextFormField(
              cursorColor: Colors.green,
              keyboardType: keyboardType,
              controller: controller,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: lightGreyColor,
                      fontSize: 15),
                  disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: texFieldColor),
                      borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: texFieldColor),
                      borderRadius: BorderRadius.circular(8)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: texFieldColor),
                      borderRadius: BorderRadius.circular(8))),
            ).paddingOnly(bottom: 0),
          ),
        ),
      ],
    );
  }
}
