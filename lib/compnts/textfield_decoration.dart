// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_chatview/compnts/theme.dart';
import 'package:flutter/material.dart';

class TextFieldDecoration {
  final int maxLines;
  final int minLines;
  final String hintText;
  final Color hintStyleColor;

  ///[textFieldDarkModeBackgroundColor] is TextFormField background color for Dark mode
  Color? textFieldDarkModeBackgroundColor;

  ///[textFieldLightModeBackgroundColor] is TextFormField background color for Light mode
  Color? textFieldLightModeBackgroundColor;

  TextFieldDecoration({
    this.maxLines = 4,
    this.minLines = 1,
    this.hintText = 'Message...',
    this.hintStyleColor = hintTextStyle,
    this.textFieldDarkModeBackgroundColor,
    this.textFieldLightModeBackgroundColor,
  });
}
