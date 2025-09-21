import 'package:bimskrip/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Loader {
  static void show(BuildContext context, {bool dismissible = false}) {
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(color: MyColors.primaryColor),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

class Helper {
  String formatTanggal(String input) {
    DateTime date = DateTime.parse(input);
    return DateFormat('d MMMM yyyy').format(date);
  }
}
