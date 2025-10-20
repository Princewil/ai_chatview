# AI Chatview
AI Chatview a customizable Flutter chat UI for AI-driven conversations with markdown and typing effects.
This package is designed **exclusively** for creating elegant, modern **AI chat interfaces** in Flutter. 

### 🧩 Features

- 🧠 **Supports full Markdown rendering**  
  Including **bold**, *italic*, <u>underline</u>, `inline code`, [links](https://pub.dev/packages/markdown_widget), and even complex widgets like lists and tables.  

- ⌨️ **Typewriter Animation**  
  Just like how an AI chatbot gradually types its responses — thanks to the built-in `TypewriterAnimatedConfiguration`. 

- 🧠 **AI-Focused Design** — Built for chatbots, assistants, and conversational UIs.


### 💡 Example Usage

```dart
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final AIChatviewController chatController;
  @override
  void initState() {
    super.initState();
    chatController = AIChatviewController(
      typewriterAnimatedConfiguration: TypewriterAnimatedConfiguration(
        typingSpeed: Duration(milliseconds: 2),
      ),
      textFieldDecoration: TextFieldDecoration(
        minLines: 2,
        maxLines: 4,
        textFieldDarkModeBackgroundColor: Colors.white,
        textFieldLightModeBackgroundColor: Colors.grey.shade300,
      ),
    );
  }

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI Chatview Package Demo')),
      body: AIChatView(
        aIChatViewController: chatController,
        onSendTap: onSend,
        emptyState: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hi, Dear how are you doing?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'This is AI Chatview Demo. Type something to get started.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        textFieldOtherWidget: IconButton(
          onPressed: () => showSnackBar("Implement your mic functinality here"),
          icon: Icon(Icons.mic),
        ),
        leftPanelWidget: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => showSnackBar("Implement any other functinality here"),
          child: CircleAvatar(
            radius: 22,
            child: Icon(Icons.auto_awesome), //bubble_chart_rounded
          ),
        ),
      ),
    );
  }

  showSnackBar(String mssg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mssg)));

  onSend() async {
    await Future.delayed(Duration(seconds: 2));
    chatController.addMessage(
      ChatModel(isUser: false, message: mockAIgeneratedText),
    );
  }
}
```

# Some important parameters
- [AIChatviewController]→ Must be initialized. This controller manages and updates the chat view UI.
- [emptyState]→ The widget displayed when the chat view has no messages.
- [textFieldOtherWidget]→ A widget that adds extra functionality (e.g., microphone, attachments) beside the text field.
- [leftPanelWidget]→ An optional widget positioned on the left side for additional features when needed.
- [aiWidget]→ A widget displayed below each AI-generated message for extra interactions such as thumbs up, report, etc.
-[aiTypingWidget]→ The widget to customize when the AI is “thinking” or generating a response.
-[TypewriterAnimatedConfiguration]→ Controls the AI typing animation speed and behavior.

# Note:
- All parameters are optional except AIChatviewController, which must be initialized.
- Remember to dispose the controller properly to avoid memory leaks.

# 🚀 Version 1.0.0 — *Initial Release*
Version 1.0.0 marks the first official release of this package!
There’s still plenty of room for improvement and community-driven enhancement — and your contributions are highly appreciated.

# 🤝 Contributing
I welcome all forms of contribution — from small fixes to major feature additions.
Every contribution helps make this project more robust and valuable for the Flutter community.

# Upcoming
- 📷 Ability to send images and other files to the AI
- 🎨 Enhanced UI aesthetics
- 🧾 Improved documentation

⭐ Don’t forget to star the repo if you find it useful.
Happy Coding! 💙