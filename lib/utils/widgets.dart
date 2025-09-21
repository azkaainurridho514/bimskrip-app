import 'package:bimskrip/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text textRandom({
  required String text,
  required double size,
  required Color color,
  int maxLine = 2,
  TextAlign textAlign = TextAlign.left,
  FontWeight fontWeight = FontWeight.bold,
}) {
  return Text(
    text,
    maxLines: maxLine,
    softWrap: true,
    overflow: TextOverflow.ellipsis,
    textAlign: textAlign,
    style: GoogleFonts.roboto(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    ),
  );
}

InputDecoration inputDecoration({required String text, Widget? icon}) {
  return InputDecoration(
    labelText: text,
    isDense: true,
    suffixIcon: icon,
    labelStyle: TextStyle(color: MyColors.blackColor, fontSize: 12),
    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: MyColors.blackColor, width: 1),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: MyColors.primaryColor, width: 2),
    ),
  );
}

Widget buttonCustom({
  required String text,
  required VoidCallback onTap,
  Color? color,
  bool disable = false,
}) {
  return GestureDetector(
    onTap: disable ? null : onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: disable ? MyColors.disableColor : color ?? MyColors.primaryColor,
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: textRandom(
        text: text,
        textAlign: TextAlign.center,
        size: 15,
        color:
            disable ? MyColors.disableTextColor : color ?? MyColors.whiteColor,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
