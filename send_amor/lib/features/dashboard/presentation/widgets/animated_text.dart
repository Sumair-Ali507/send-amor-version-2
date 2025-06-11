import 'package:flutter/material.dart';
import 'dart:async';

import '../../../../common/mixins/ts.dart';

class AnimatedText extends StatefulWidget {
  final String fullText;
  final Duration duration; // Time interval between showing characters.

  const AnimatedText({
    super.key,
    required this.fullText,
    this.duration = const Duration(milliseconds: 100),
  });

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  String _displayedText = '';
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAnimation() {
    _timer = Timer.periodic(widget.duration, (timer) {
      setState(() {
        if (_currentIndex < widget.fullText.length) {
          _displayedText += widget.fullText[_currentIndex];
          _currentIndex++;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText,
      textAlign: TextAlign.center,
      style: Ts.boldStyle(context: context, size: 18.0),
    );
  }
}
