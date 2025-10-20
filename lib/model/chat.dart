class ChatModel {
  final String message;

  ///Is [isUser] is true, if the [message] was sent by the user
  final bool isUser;

  ///This also severs as the DateTime in [millisecondsSinceEpoch].˝
  final int mssgID;

  ChatModel({this.message = '', this.isUser = false, int? mssgID})
    : mssgID = mssgID ?? DateTime.now().millisecondsSinceEpoch;

  Map toMap(ChatModel chatModel) {
    final Map<String, dynamic> map = {};
    map['message'] = chatModel.message;
    map['messageID'] = chatModel.mssgID;
    map['IsUser'] = chatModel.isUser;
    return map;
  }

  ///A simple funct to convert to Map to [ChatModel]
  ChatModel toClass(Map map) => ChatModel(
    message: map['message'],
    mssgID: map['messageID'],
    isUser: map['IsUser'],
  );
}

///This is a constant that gets injected when AI is thinking
final aiIsThinkingModel = ChatModel(isUser: false, message: '', mssgID: -1);
