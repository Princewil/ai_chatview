import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool isDarkMode([BuildContext? context]) {
  if (context != null) {
    return Theme.of(context).brightness == Brightness.dark;
  }
  return PlatformDispatcher.instance.platformBrightness == Brightness.dark;
}
