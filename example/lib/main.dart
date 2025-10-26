import 'package:ai_chatview/chatview.dart';
import 'package:ai_chatview/compnts/text_animation.dart';
import 'package:ai_chatview/compnts/textfield_decoration.dart';
import 'package:ai_chatview/model/chat.dart';
import 'package:ai_chatview/model/controller.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI ChatView Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Home(),
    );
  }
}

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
      textFieldDecoration: TextFieldDecoration(minLines: 2, maxLines: 4),
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
        aiWidget: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.thumb_up_alt)),
                IconButton(onPressed: () {}, icon: Icon(Icons.thumb_down)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'AI is not always correct',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
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

const String mockAIgeneratedText = """
## 👋 Hi there!

**Welcome to the _AI Chatview_ package!**  
This package is designed **exclusively** for creating elegant, modern **AI chat interfaces** in Flutter.  

---

### 🧩 Features

- 🧠 **Supports full Markdown rendering**  
  Including **bold**, *italic*, <u>underline</u>, `inline code`, [links](https://pub.dev/packages/markdown_widget), and even complex widgets like lists and tables.  

- ⌨️ **Typewriter Animation**  
  Just like how an AI chatbot gradually types its responses — thanks to the built-in `TypewriterAnimatedConfiguration`.

- 🎨 **Highly Customizable UI**  
  You can style bubbles, avatars, message alignment, and animations however you want!
 
- ⚙️ **Stream-Based Updates** — Reactive message updates without manual `setState()` calls.  

- 🧠 **AI-Focused Design** — Built for chatbots, assistants, and conversational UIs.  


---

## 🧱 Supported Widgets

Below is a list of **widgets and features** supported by the **AI Chatview** package, along with a short description of what each does.

| **Widget / Feature**             | **Description**                                                                 |
|----------------------------------|---------------------------------------------------------------------------------|
| `AIChatView`                     | The main chat view that displays user and AI messages with smooth animations.  |
| `ChatTextInputWidget`            | The customizable message input field with typewriter and markdown support.     |
| `ChatModel`                      | Defines the structure of each chat message (AI or user).                       |
| `AIChatviewController`           | Central controller for managing messages, streams, and input behavior.         |
| `TypewriterAnimatedText`         | Animates text character-by-character to simulate AI typing.                    |
| `MessageBubble`                  | Automatically formats and styles chat messages with markdown rendering.        |
| `TextFieldDecoration`            | Provides theme-based customization for text input appearance.                  |
| `TypingIndicator`                | Shows a live typing animation when the AI is generating a response.            |
| `MarkdownWidget` *(Integrated)*  | Renders markdown syntax (bold, italics, links, code, lists, etc.) beautifully. |
| `ChatTheme`                      | Handles both light and dark themes for a modern, minimal look.                 |

---



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

## 🚀 Version 1.0.0 — *Initial Release*

This version marks the beginning of an exciting journey toward building the most flexible, elegant, and AI-ready chat UI for Flutter developers.  

---

## 🤝 Contributing

I'm thrilled that you're interested in contributing to **AI Chatview**! 💡  
Every contribution — big or small — helps improve this project and makes it more useful for the Flutter community.

---

""";
