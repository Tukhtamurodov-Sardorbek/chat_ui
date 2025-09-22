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
}
