import 'dart:async';
import 'package:flutter/material.dart';

class FadeIn extends StatefulWidget {
  final Duration duration;
  final Duration delay;
  final Widget child;

  const FadeIn({
    Key? key,
    required this.duration,
    required this.child,
    required this.delay,
  }) : super(key: key);

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> {
  bool _shouldActivate = false;

  @override
  void initState() {
    Timer(
      widget.delay,
      displayContent,
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _shouldActivate ? 1.0 : 0.0,
      duration: widget.duration,
      child: widget.child,
    );
  }

  void displayContent() {
    setState(() {
      _shouldActivate = !_shouldActivate;
    });
  }
}
