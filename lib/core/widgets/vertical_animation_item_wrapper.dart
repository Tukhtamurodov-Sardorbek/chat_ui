import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
export 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class VerticalAnimationItemWrapper extends StatelessWidget {
  final Widget child;
  final int position;
  final int milliseconds;
  final Curve curve;
  final double? verticalOffset;

  const VerticalAnimationItemWrapper({
    super.key,
    required this.child,
    required this.position,
    this.milliseconds = 450,
    this.verticalOffset,
    this.curve = Curves.ease,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: position,
      duration: const Duration(milliseconds: 100),
      child: FadeInAnimation(
        curve: curve,
        duration: Duration(milliseconds: milliseconds),
        child: SlideAnimation(
          curve: curve,
          verticalOffset: verticalOffset ?? 50.0,
          duration: Duration(milliseconds: milliseconds),
          child: child,
        ),
      ),
    );
  }
}
