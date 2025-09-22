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
        padding: EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return SizedBox();
          }, childCount: chatMessages.messages.length),
        ),
      ),
    );
  }
}
