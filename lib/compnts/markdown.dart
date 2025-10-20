import 'package:ai_chatview/model/controller.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/widget/all.dart';

import 'compnt.dart';

class TypewriterMarkdown extends StatefulWidget {
  final String text;
  final AIChatviewController chatController;
  const TypewriterMarkdown({
    super.key,
    required this.text,
    required this.chatController,
  });

  @override
  State<TypewriterMarkdown> createState() => TypewriterMarkdownState();
}

class TypewriterMarkdownState extends State<TypewriterMarkdown> {
  String _displayedText = "";
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() async {
    if (!allowTyping) return;
    while (_currentIndex < widget.text.length) {
      // typing speed
      await Future.delayed(
        widget.chatController.typewriterAnimatedConfiguration.typingSpeed,
      );
      if (!mounted) return;
      setState(() {
        _currentIndex++;
        _displayedText = widget.text.substring(0, _currentIndex);
      });
      //We dont want to scroll to botton at every frame
      //scrollToBottom();
      if (_currentIndex >= widget.text.length) {
        //After typing is done. We disable typing. To solve the bug that cause typing when scrolling
        allowTyping = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MarkdownWidget(
      data: _displayedText.isEmpty ? "..." : _displayedText,
      shrinkWrap: true,
    );
  }
}
