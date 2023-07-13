import 'dart:async';

import 'package:flutter/cupertino.dart';

class AnimationApp extends StatefulWidget {
  final Widget child; // widget appeler plus tard
  final int delay; //temps
  const AnimationApp({Key? key,
    required this.child,
    required this.delay}) : super(key: key);

  @override
  State<AnimationApp> createState() => _AnimationAppState();
}

class _AnimationAppState extends State<AnimationApp>
    with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _animationOffset; // offset utuliser  pour le décalage des animation
  @override
  void initState(){ //initialiser une animation
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500 ), //duré de l'animation
    );
    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    );
    _animationOffset = Tween<Offset>(
      begin: Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(curve);
    //durer de l'animation
    Timer(Duration(milliseconds: widget.delay),() {
      _controller.forward();

    });
  }
  // initialiser l'animation
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(position: _animationOffset,
        child: widget.child,
      ),

    );
  }
}
