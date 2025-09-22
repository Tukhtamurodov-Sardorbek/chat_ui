part of '../chat_details_page.dart';

class _SliverStickyHeaderView extends StatelessWidget {
  final bool isFirst;
  final ChatMessages chatMessages;

  const _SliverStickyHeaderView({
    required this.isFirst,
    required this.chatMessages,
  });

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader.builder(
      builder: (context, state) {
        return Container(
          decoration: state.isPinned
              ? BoxDecoration(
                  color: Colors.grey,
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 16,
                      offset: Offset(0, 4),
                      color: Color(0x26000000),
                    ),
                  ],
                )
              : null,
          child: Center(
            child: Text(
              chatMessages.date.formatDate,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF838997),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
      sliver: SliverPadding(
        padding: EdgeInsets.all(16),
        sliver: AnimationLimiter(
          child: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final isSentByThisUser =
                  chatMessages.messages[index].isSentByThisUser;
              bool isNextMsgOwnerDifferent = false;
              if (index + 1 != chatMessages.messages.length) {
                isNextMsgOwnerDifferent =
                    isSentByThisUser !=
                    chatMessages.messages[index + 1].isSentByThisUser;
              }
              return Align(
                alignment: isSentByThisUser
                    ? Alignment.centerRight
                    : AlignmentGeometry.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 4.0 + (isNextMsgOwnerDifferent ? 8 : 0),
                  ),
                  child: VerticalAnimationItemWrapper(
                    position: index,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft: isSentByThisUser
                              ? Radius.circular(16)
                              : Radius.zero,
                          bottomRight: isSentByThisUser
                              ? Radius.zero
                              : Radius.circular(16),
                        ),
                        color: isSentByThisUser
                            ? Color(0xFFE94F11)
                            : Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          chatMessages.messages[index].message,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }, childCount: chatMessages.messages.length),
          ),
        ),
      ),
    );
  }
}
