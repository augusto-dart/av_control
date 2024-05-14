import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

mixin Utils on StatelessWidget {
  void displayToast(BuildContext context, String message) {
    MotionToast.warning(
      title: const Text(
        'Atenção',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(
        message,
      ),
      position: MotionToastPosition.top,
      animationDuration: const Duration(milliseconds: 250),
      toastDuration: const Duration(seconds: 2),
    ).show(context);
  }

  void showSucessMessage(BuildContext context, String message) {
    MotionToast.success(
      title: const Text(
        'Sucesso!',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(
        message,
      ),
      position: MotionToastPosition.top,
      animationDuration: const Duration(milliseconds: 250),
      toastDuration: const Duration(seconds: 2),
    ).show(context);
  }

  void showErrorMessage(BuildContext context, String message) {
    MotionToast.error(
      title: const Text(
        'Erro',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(
        message,
      ),
      position: MotionToastPosition.top,
      animationDuration: const Duration(milliseconds: 250),
      toastDuration: const Duration(seconds: 2),
    ).show(context);
  }
}
