// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_chatview/compnts/theme.dart';
import 'package:flutter/material.dart';

class TextFieldDecoration {
  final int maxLines;
  final int minLines;
  final String hintText;
  final Color hintStyleColor;

  TextFieldDecoration({
    this.maxLines = 4,
    this.minLines = 1,
    this.hintText = 'Message...',
    this.hintStyleColor = hintTextStyle,
  });
}
