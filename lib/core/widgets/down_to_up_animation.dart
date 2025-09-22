import 'package:chat_ui/core/extensions/widget_ext.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/material.dart';

enum AnimationTypeDownToUp { opacity, translateY }

class DownToUp extends StatelessWidget {
  final double delayFactor;
  final Widget child;
  final bool withPosition;
  final bool reversePosition;
  final Function()? onFinish;
  final bool applyOpacityAnimation;

  const DownToUp({
    super.key,
    required this.delayFactor,
    required this.child,
    this.withPosition = true,
    this.reversePosition = false,
    this.onFinish,
    this.applyOpacityAnimation = true,
  });

  @override
  Widget build(BuildContext context) {
    final movie = MovieTween()
      ..tween(
        AnimationTypeDownToUp.translateY,
        Tween(begin: reversePosition ? -100.0 : 100.0, end: 0.0),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutExpo,
      );
    if (applyOpacityAnimation) {
      movie.tween(
        AnimationTypeDownToUp.opacity,
        Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 800),
      );
    }

    return PlayAnimationBuilder<Movie>(
      tween: movie,
      onCompleted: onFinish,
      duration: movie.duration,
      delay: Duration(milliseconds: (500 * delayFactor).round()),
      builder: (context, value, _) {
        return child
            .conditionalWrapper(
              condition: withPosition,
              wrapper: (child) {
                final offsetY = value.get(AnimationTypeDownToUp.translateY);
                return Transform.translate(
                  offset: Offset(0, offsetY),
                  child: child,
                );
              },
            )
            .conditionalWrapper(
              condition: applyOpacityAnimation,
              wrapper: (child) {
                final opacity = value.get(AnimationTypeDownToUp.opacity);
                return Opacity(opacity: opacity, child: child);
              },
            );
      },
      child: child,
    );
  }
}

@optionalTypeArgs
mixin SequentialDownToUp {
  double? _delay, _delta;
  Map<int, int>? _slots;

  // @protected
  // double get defaultInitDelay;
  //
  // @protected
  // Map<int, int> get slotsPerOrder;

  ({double defaultInitDelay, double? delta, Map<int, int> slotsPerOrder})
  get setupSequence;

  // @nonVirtual
  @protected
  double delayFactor(int order, [int? index]) {
    if (_delay == null || _delta == null || _slots == null) {
      final record = setupSequence;
      _delta = record.delta ?? 0.1;
      _slots = record.slotsPerOrder;
      _delay = record.defaultInitDelay;
    }

    if (order == 0) {
      return _delay! - 0.1;
    }
    if (order < 0) {
      final result = _delay! - ((1 - order) / 100);
      return result.isNegative ? 0 : result;
    }
    int basePosition = 0;

    for (int i = 1; i < order; i++) {
      basePosition += _slots?[i] ?? 1;
    }

    int position = basePosition + (index ?? 0);
    final result = double.parse(
      (_delay! + position * _delta!).toStringAsFixed(1),
    );
    return result;
  }
}
