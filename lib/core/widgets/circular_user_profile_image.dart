import 'package:flutter/material.dart';

class CircularUserProfileImage extends StatelessWidget {
  final double imageSize;
  final String image;
  final bool isOnline;

  const CircularUserProfileImage({
    super.key,
    required this.imageSize,
    required this.image,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(radius: imageSize / 2, backgroundImage: AssetImage(image)),

        // Status indicator
        Positioned(
          bottom: 1,
          right: 1,
          child: SizedBox.square(
            dimension: 12,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: isOnline ? Color(0xFF08CB77) : Color(0xFFB5BBC9),
                shape: BoxShape.circle,
                border: Border.all(width: 3, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
