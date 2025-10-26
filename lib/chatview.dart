import 'package:ai_chatview/model/chat.dart';
import 'package:ai_chatview/model/controller.dart';
import 'package:flutter/material.dart';

import 'compnts/compnt.dart';
import 'compnts/build_messages.dart';
import 'compnts/textinput_field.dart';
import 'compnts/darkmode.dart';
import 'compnts/theme.dart';

class AIChatView extends StatelessWidget {
  ///[aIChatViewController] is required.
  final AIChatviewController aIChatViewController;

  ///[emptyState] is the default state that would be displayed if there is not chat
  final Widget emptyState;

  ///[aiTypingWidget] Widget to display when AI is still get data
  final Widget? aiTypingWidget;

  ///[aiWidget]This widget is placed below each AI text. Used this when you intend to put a thumbs-up, report or other widget below each AI text
  final Widget? aiWidget;

  ///[onSendTap] Callback when message is sent by user
  final VoidCallback? onSendTap;

  ///[textFieldOtherWidget]This widget is placed within the textfield. Used when you intend to put other functionalities like mic
  final Widget? textFieldOtherWidget;

  ///[leftPanelWidget]This is for placing widget at the left side of the TextformField for added functionalities
  final Widget? leftPanelWidget;

  ///[aIChatViewController] is required.
  ///
  ///[emptyState] is the default state that would be displayed if there is not chat
  ///
  ///[aiTypingWidget] Widget to display when AI is still get data
  ///
  ///[aiWidget]This widget is placed below each AI text. Used this when you intend to put a thumbs-up, report or other widget below each AI text
  ///
  ///[aiWidget]This widget is placed below each AI text. Used this when you intend to put a thumbs-up, report or other widget below each AI text
  ///
  ///[textFieldOtherWidget]This widget is placed within the textfield. Used when you intend to put other functionalities like mic
  ///
  ///[leftPanelWidget]This is for placing widget at the left side of the TextformField for added functionalities
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
    userInputBackGroundColor = isDarkMode(context)
        ? Colors.white
        : Colors.grey.shade300;
    return StreamBuilder<List<ChatModel>>(
      stream: aIChatViewController.messageStreamController.stream,
      initialData: aIChatViewController.initialMessageList,
      builder: (context, data) {
        final chats = data.data ?? [];
        return Stack(
          children: [
            chats.isEmpty
                ? emptyState
                : ListView.builder(
                    padding: EdgeInsets.only(bottom: 200),
                    physics: ClampingScrollPhysics(),
                    controller: aIChatViewController.scrollController,
                    itemCount: chats.length,
                    itemBuilder: (_, index) => BuildMessage(
                      chats[index],
                      chatController: aIChatViewController,
                      allChats: chats,
                    ),
                  ),
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Column(
                children: [
                  Expanded(child: SizedBox()),
                  ChatTextInputWidget(chatController: aIChatViewController),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
