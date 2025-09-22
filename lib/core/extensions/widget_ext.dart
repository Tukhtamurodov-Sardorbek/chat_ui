import 'package:chat_ui/core/widgets/down_to_up_animation.dart';
import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget buttonize({
    required VoidCallback? onTap,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    Color? highlightColor,
    Color? splashColor,
    Color? backgroundColor,
    Decoration? decoration,
  }) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        splashFactory: InkSplash.splashFactory,
        child: Ink(
          padding: padding,
          decoration:
              decoration ??
              BoxDecoration(
                color: backgroundColor ?? Colors.transparent,
                borderRadius: borderRadius,
              ),
          child: this,
        ),
      ),
    );
  }

  Widget conditionalWrapper({
    required bool condition,
    required Widget Function(Widget child) wrapper,
  }) {
    return condition ? wrapper(this) : this;
  }

  Widget wrapWithDownToUpAnimation({
    Key? key,
    required double delayFactor,
    bool withPosition = true,
    bool reversePosition = false,
    Function()? onFinish,
    bool applyOpacityAnimation = true,
  }) {
    return DownToUp(
      key: key,
      onFinish: onFinish,
      reversePosition: reversePosition,
      delayFactor: delayFactor,
      applyOpacityAnimation: applyOpacityAnimation,
      child: this,
    );
  }
}
