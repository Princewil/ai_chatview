import 'package:ai_chatview/model/chat.dart';
import 'package:ai_chatview/model/controller.dart';
import 'package:flutter/material.dart';

import 'compnts/compnt.dart';
import 'compnts/build_messages.dart';
import 'compnts/textinput_field.dart';
import 'compnts/darkmode.dart';
import 'compnts/theme.dart';

///[aIChatViewController] is required.
///[emptyState] is the default state that would be displayed if there is not chat
///[onSendTap] Callback when message is sent by user
///[aiTypingWidget] Widget to display when AI is still get data
///[aiWidget]This widget is placed below each AI text. Used this when you intend to put a thumbs-up, report or other widget below each AI text
///[textFieldOtherWidget]This widget is placed within the textfield. Used when you intend to put other functionalities like mic
///[leftPanelWidget]This is for placing widget at the left side of the TextformField for added functionalities
class AIChatView extends StatelessWidget {
  final AIChatviewController aIChatViewController;
  final Widget emptyState;
  final Widget? aiTypingWidget;
  final Widget? aiWidget;
  final VoidCallback? onSendTap;
  final Widget? textFieldOtherWidget;
  final Widget? leftPanelWidget;
  const AIChatView({
    super.key,
    required this.aIChatViewController,
    this.emptyState = const SizedBox(),
    this.onSendTap,
    this.aiTypingWidget,
    this.aiWidget,
    this.textFieldOtherWidget,
    this.leftPanelWidget,
  });

  @override
  Widget build(BuildContext context) {
    kOnSendTap = onSendTap;
    kAiTypingWidget = aiTypingWidget;
    kAiWidget = aiWidget;
    kTextFieldOtherWidget = textFieldOtherWidget;
    kLeftPanelWidget = leftPanelWidget;
    backgroundColor = isDarkMode(context)
        ? aIChatViewController
              .textFieldDecoration
              .textFieldDarkModeBackgroundColor
        : aIChatViewController
              .textFieldDecoration
              .textFieldLightModeBackgroundColor;
    return StreamBuilder<List<ChatModel>>(
      stream: aIChatViewController.messageStreamController.stream,
      builder: (context, data) {
        final chats = data.data ?? [];
        return Column(
          children: [
            Expanded(
              child: chats.isEmpty
                  ? emptyState
                  : ListView.builder(
                      physics: ClampingScrollPhysics(),
                      controller: aIChatViewController.scrollController,
                      itemCount: chats.length,
                      itemBuilder: (_, index) => BuildMessage(
                        chats[index],
                        chatController: aIChatViewController,
                        allChats: chats,
                      ),
                    ),
            ),
            ChatTextInputWidget(chatController: aIChatViewController),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
