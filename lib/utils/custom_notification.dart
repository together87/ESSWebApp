import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

enum NotifyType {
  success,
  info,
  error,
}

class CustomNotification {
  final BuildContext context;
  final NotifyType notifyType;
  final String? title;
  final String content;
  final double width;
  final int duration;
  CustomNotification({
    required this.context,
    required this.notifyType,
    this.title,
    required this.content,
    this.width = 400,
    this.duration = 5,
  });

  void showNotification() {
    switch (notifyType) {
      case NotifyType.success:
        toastification.showSuccess(
          showProgressBar: true,
          showCloseButton: true,
          context: context,
          autoCloseDuration: Duration(seconds: duration),
          title: title ?? '',
          animationDuration: const Duration(milliseconds: 300),
          description: content,
        );
        break;
      case NotifyType.info:
        toastification.showInfo(
          showProgressBar: true,
          showCloseButton: true,
          context: context,
          title: title ?? '',
          autoCloseDuration: Duration(seconds: duration),
          animationDuration: const Duration(milliseconds: 300),
          description: content,
        );
        break;
      case NotifyType.error:
        toastification.showError(
          showProgressBar: true,
          showCloseButton: true,
          context: context,
          autoCloseDuration: Duration(seconds: duration),
          animationDuration: const Duration(milliseconds: 300),
          title: title ?? '',
          description: content,
        );
        break;
    }
  }
}
