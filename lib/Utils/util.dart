import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

class Utils {
  static double height = 150.0;
  static double width = 500.0;

  static displayToast(BuildContext context, String message) {
    CherryToast.warning(
      title: const Text(
        'Atenção',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(
        message,
      ),
      height: height,
      width: width,
      inheritThemeColors: true,
      toastPosition: Position.top,
      animationDuration: const Duration(milliseconds: 250),
      toastDuration: const Duration(seconds: 2),
    ).show(context);
  }

  static void showSucessMessage(BuildContext context, String message) {
    CherryToast.success(
      title: const Text(
        'Sucesso!',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(
        message,
      ),
      height: height,
      width: width,
      inheritThemeColors: true,
      toastPosition: Position.top,
      animationDuration: const Duration(milliseconds: 250),
      toastDuration: const Duration(seconds: 2),
    ).show(context);
  }

  static void showErrorMessage(BuildContext context, String message) {
    CherryToast.error(
      title: const Text(
        'Erro',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(
        message,
      ),
      height: height,
      width: width,
      inheritThemeColors: true,
      toastPosition: Position.top,
      animationDuration: const Duration(milliseconds: 250),
      toastDuration: const Duration(seconds: 2),
    ).show(context);
  }

  static bool largeScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width > 900;
  }
}
