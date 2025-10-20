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
    final backgroundColor = isDarkMode(context)
        ? widget
              .chatController
              .textFieldDecoration
              .textFieldDarkModeBackgroundColor
        : widget
              .chatController
              .textFieldDecoration
              .textFieldLightModeBackgroundColor;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ).copyWith(bottom: 10, top: 10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (kLeftPanelWidget != null) kLeftPanelWidget!,
          if (kLeftPanelWidget != null) SizedBox(width: 10),
          Expanded(
            child: Container(
              //constraints: const BoxConstraints(minHeight: 10),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 25),
                      child: Center(
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          controller:
                              widget.chatController.textEdittingController,
                          maxLines: widget
                              .chatController
                              .textFieldDecoration
                              .maxLines,
                          minLines: widget
                              .chatController
                              .textFieldDecoration
                              .minLines,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          onSubmitted: (_) => onTap(),
                          // onTapUpOutside: (_) => KeyboardUtil.hideKeyboard(context),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: widget
                                .chatController
                                .textFieldDecoration
                                .hintText,
                            hintStyle: TextStyle(
                              color: widget
                                  .chatController
                                  .textFieldDecoration
                                  .hintStyleColor,
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
                      ),
                    ),
                  ),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    transitionBuilder: (child, anim) =>
                        ScaleTransition(scale: anim, child: child),
                    child: _userIsTyping
                        ? IconButton(
                            icon: Icon(Icons.near_me_rounded),
                            onPressed: onTap,
                          )
                        : kTextFieldOtherWidget ?? SizedBox(),
                  ),
                ],
              ),
            ),
          ),
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
        isTyping: false,
      ),
    );
    widget.chatController.textEdittingController.clear();
    setState(() {
      _userIsTyping = false;
    });
  }
}
