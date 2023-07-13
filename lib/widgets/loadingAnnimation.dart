import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnnimationWidget extends StatelessWidget {
  const LoadingAnnimationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: LoadingAnimationWidget.flickr(
        leftDotColor: const Color(0xFF1A1A3F),
    rightDotColor: const Color(0xFFEA3799),
    size: 70,
    ),
    ),
    );
  }
}
