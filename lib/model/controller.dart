import 'dart:async';
import 'package:ai_chatview/compnts/compnt.dart';
import 'package:ai_chatview/compnts/textfield_decoration.dart';
import 'package:ai_chatview/model/chat.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../compnts/text_animation.dart';

class AIChatviewController {
  /// Represents initial message list in chat which can be add by user.
  List<ChatModel> initialMessageList;

  ScrollController scrollController;

  ///[textFieldDecoration] For TextFormfield Decoration
  TextFieldDecoration textFieldDecoration;

  /// Allow user to show typing indicator defaults to false.
  final ValueNotifier<bool> _showTypingIndicator = ValueNotifier(false);

  /// TypingIndicator as [ValueNotifier] for [GroupedChatList] widget's typingIndicator [ValueListenableBuilder].
  ///  Use this for listening typing indicators
  ///   ```dart
  ///    chatcontroller.typingIndicatorNotifier.addListener((){});
  ///  ```
  /// For more functionalities see [ValueNotifier].
  ValueListenable<bool> get typingIndicatorNotifier => _showTypingIndicator;

  /// Getter for typingIndicator value instead of accessing [_showTypingIndicator.value]
  /// for better accessibility.
  bool get showTypingIndicator => _showTypingIndicator.value;

  /// Setter for changing values of typingIndicator
  /// ```dart
  ///  chatContoller.setTypingIndicator = true; // for showing indicator
  ///  chatContoller.setTypingIndicator = false; // for hiding indicator
  ///  ````
  set setTypingIndicator(bool value) => _showTypingIndicator.value = value;

  ///Configuration for Animated Typewriter functionality as in a chatbot.
  TypewriterAnimatedConfiguration typewriterAnimatedConfiguration;

  ///Gives us control of the TextEditting controller of the TextField of the current user
  TextEditingController textEdittingController;

  AIChatviewController({
    List<ChatModel>? initialMessageList,
    ScrollController? scrollController,
    TextFieldDecoration? textFieldDecoration,
    TextEditingController? textEdittingController,
    TypewriterAnimatedConfiguration? typewriterAnimatedConfiguration,
  }) : initialMessageList = initialMessageList ?? [],
       typewriterAnimatedConfiguration =
           typewriterAnimatedConfiguration ?? TypewriterAnimatedConfiguration(),
       textEdittingController =
           textEdittingController ?? TextEditingController(),
       textFieldDecoration = textFieldDecoration ?? TextFieldDecoration(),
       scrollController = scrollController ?? ScrollController();

  /// Represents message stream of chat
  StreamController<List<ChatModel>> messageStreamController =
      StreamController();

  /// Used to dispose ValueNotifiers and Streams.
  void dispose() {
    _showTypingIndicator.dispose();
    scrollController.dispose();
    messageStreamController.close();
  }

  /// Used to add message in message list.
  void addMessage(ChatModel message) {
    scrollToBottom();
    allowTyping = true;
    if (message.isUser) {
      initialMessageList.addAll([message, aiIsThinkingModel]);
    } else {
      initialMessageList.remove(aiIsThinkingModel);
      initialMessageList.add(message);
    }
    if (!messageStreamController.isClosed) {
      messageStreamController.sink.add(initialMessageList);
    }
  }

  /// Used to clearing message in message list.
  void clearMessage() {
    initialMessageList.clear();
    if (!messageStreamController.isClosed) {
      messageStreamController.sink.add(initialMessageList);
    }
  }

  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 200,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  ///For enabling AI thinking
  void enableAIThinking() {
    addMessage(aiIsThinkingModel);
  }

  ///For disabling AI thinking
  void disableAIThinking() {
    initialMessageList.removeWhere((e) => e.mssgID == aiIsThinkingModel.mssgID);
    addMessage(aiIsThinkingModel);
  }
}
