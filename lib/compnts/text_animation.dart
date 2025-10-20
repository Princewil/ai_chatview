///Configuration for Animated Typewriter functionality as in a chatbot.
class TypewriterAnimatedConfiguration {
  ///[typingSpeed] is the By default it is set to 10 milliseconds.
  final Duration typingSpeed;

  TypewriterAnimatedConfiguration({
    this.typingSpeed = const Duration(milliseconds: 10),
  });
}
