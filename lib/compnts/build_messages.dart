import 'package:ai_chatview/model/controller.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/widget/all.dart';

import '../model/chat.dart';
import 'markdown.dart';
import 'compnt.dart';
import 'theme.dart';

class BuildMessage extends StatelessWidget {
  final ChatModel message;
  final List<ChatModel> allChats;
  final AIChatviewController chatController;
  const BuildMessage(
    this.message, {
    super.key,
    required this.chatController,
    required this.allChats,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    if (message.mssgID == aiIsThinkingModel.mssgID) {
      if (kAiTypingWidget != null) {
        return kAiTypingWidget!;
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          children: [
            SizedBox(width: 10),
            Text(
              "Thinking...",
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: kBodyTextColor,
              ),
            ),
          ],
        ),
      );
    }

    if (isUser) {
      return Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(width: MediaQuery.sizeOf(context).width * 0.15),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(message.message, style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      );
    }

    // AI message — full-width with Markdown, no bubble
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child:
                    allChats.last.mssgID == message.mssgID &&
                        allowTyping //The purpose of this is to ensure the typing animation animates on only the last chat.
                    ? TypewriterMarkdown(
                        text: message.message,
                        chatController: chatController,
                      )
                    : MarkdownWidget(data: message.message, shrinkWrap: true),
              ),
            ],
          ),
          if (kAiWidget != null) kAiWidget!,
        ],
      ),
    );
  }
}
