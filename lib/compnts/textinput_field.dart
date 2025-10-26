import 'package:ai_chatview/compnts/darkmode.dart';
import 'package:ai_chatview/model/controller.dart';
import 'package:flutter/material.dart';

import '../model/chat.dart';
import 'compnt.dart';

bool _userIsTyping = false;

class ChatTextInputWidget extends StatefulWidget {
  final AIChatviewController chatController;
  const ChatTextInputWidget({super.key, required this.chatController});

  @override
  State<ChatTextInputWidget> createState() => _ChatTextInputWidgetState();
}

class _ChatTextInputWidgetState extends State<ChatTextInputWidget> {
  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            textAlignVertical: TextAlignVertical.center,
            controller: widget.chatController.textEdittingController,
            maxLines: widget.chatController.textFieldDecoration.maxLines,
            minLines: widget.chatController.textFieldDecoration.minLines,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            onSubmitted: (_) => onTap(),
            // onTapUpOutside: (_) => KeyboardUtil.hideKeyboard(context),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.chatController.textFieldDecoration.hintText,
              hintStyle: TextStyle(
                color: widget.chatController.textFieldDecoration.hintStyleColor,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 12,
              ),
            ),
            onChanged: (s) {
              final isTyping = s.trim().isNotEmpty;
              if (isTyping != _userIsTyping) {
                setState(() => _userIsTyping = isTyping);
              }
            },
          ),
          SizedBox(height: 10),
          Row(
            children: [
              if (kLeftPanelWidget != null) kLeftPanelWidget!,
              Spacer(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                transitionBuilder: (child, anim) =>
                    ScaleTransition(scale: anim, child: child),
                child: _userIsTyping
                    ? InkWell(
                        onTap: onTap,
                        borderRadius: BorderRadius.circular(22),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: isDark
                              ? Colors.white
                              : Colors.black87,
                          child: Icon(
                            Icons.near_me_rounded,
                            color: isDark ? Colors.black : Colors.white,
                          ),
                        ),
                      )
                    : kTextFieldOtherWidget ?? SizedBox(),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  onTap() {
    kOnSendTap?.call();
    widget.chatController.addMessage(
      ChatModel(
        isUser: true,
        message: widget.chatController.textEdittingController.text,
      ),
    );
    widget.chatController.textEdittingController.clear();
    setState(() {
      _userIsTyping = false;
    });
  }
}
