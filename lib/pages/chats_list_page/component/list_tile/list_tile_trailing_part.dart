part of 'list_tile.dart';

class _TrailingView extends StatelessWidget {
  const _TrailingView({super.key});

  @override
  Widget build(BuildContext context) {
    final chatData = chatController.chats.firstWhereOrNull(
      (chat) => chat.otherUserId == ChatPreviewTile.of(context).chatterData.id,
    );
    final hasNewMessages = chatData?.newMessages.isNotEmpty ?? false;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) {
        final curved = CurvedAnimation(parent: animation, curve: Curves.ease);
        return FadeTransition(
          opacity: Tween(begin: 0.2, end: 1.0).animate(curved),
          child: ScaleTransition(
            scale: Tween(begin: 0.4, end: 1.0).animate(curved),
            child: child,
          ),
        );
      },
      child: hasNewMessages
          ? DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0xFFE94F11),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  chatData!.newMessages.first.messages.length.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
