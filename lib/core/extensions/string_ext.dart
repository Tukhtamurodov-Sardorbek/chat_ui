import 'package:flutter/material.dart';

extension StringExt on String {
  Image displayImage({
    Key? key,
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.scaleDown,
    Alignment alignment = Alignment.center,
    BlendMode colorBlendMode = BlendMode.srcIn,
  }) {
    return Image(
      key: key,
      fit: fit,
      color: color,
      width: width,
      height: height,
      alignment: alignment,
      colorBlendMode: colorBlendMode,
      image: AssetImage(this),
    );
  }

  IconButton displayIconButton({
    required VoidCallback? onTap,
    double? size,
    Color? color,
  }) {
    return IconButton(
      onPressed: onTap,
      color: color,
      iconSize: size ?? 20,
      icon: displayImage(height: size, width: size),
      style: IconButton.styleFrom(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        foregroundColor: color,
        // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
