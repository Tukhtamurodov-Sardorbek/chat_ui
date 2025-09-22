part of 'list_tile.dart';

class _LeadingView extends StatelessWidget {
  const _LeadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ChatPreviewTile.of(context).chatterData;
    return Stack(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage(data.profileImage),
        ),

        // Status indicator
        Positioned(
          bottom: 1,
          right: 1,
          child: SizedBox.square(
            dimension: 12,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: data.isOnline ? Color(0xFF08CB77) : Color(0xFFB5BBC9),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  // adds the white border like in your screenshot
                  width: 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
