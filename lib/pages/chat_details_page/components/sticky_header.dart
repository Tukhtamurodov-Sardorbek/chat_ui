part of '../chat_details_page.dart';

class _SliverStickyHeaderView extends StatefulWidget {
  final int position;
  final ChatMessages chatMessages;
  final bool isOnline;
  final bool hasNewMessages;

  const _SliverStickyHeaderView({
    required this.position,
    required this.chatMessages,
    required this.isOnline,
    required this.hasNewMessages,
  });

  @override
  State<_SliverStickyHeaderView> createState() =>
      _SliverStickyHeaderViewState();
}

class _SliverStickyHeaderViewState extends State<_SliverStickyHeaderView>
    with SequentialDownToUp {
  @override
  ({double defaultInitDelay, double? delta, Map<int, int> slotsPerOrder})
  get setupSequence {
    return (
      delta: 0.026,
      defaultInitDelay: 0.3,
      slotsPerOrder: {1: 1, 2: widget.chatMessages.messages.length},
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader.builder(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(2),
          decoration: state.isPinned
              ? BoxDecoration(
                  color: Colors.white,
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
              widget.chatMessages.date.formatDate,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF838997),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ).wrapWithDownToUpAnimation(
          delayFactor: delayFactor(1, widget.position),
        );
      },
      sliver: SliverPadding(
        padding: EdgeInsets.all(16),
        sliver: AnimationLimiter(
          child: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final isSentByThisUser =
                  widget.chatMessages.messages[index].isSentByThisUser;
              bool isNextMsgOwnerDifferent = false;
              if (index + 1 != widget.chatMessages.messages.length) {
                isNextMsgOwnerDifferent =
                    isSentByThisUser !=
                    widget.chatMessages.messages[index + 1].isSentByThisUser;
              }
              return Align(
                alignment: isSentByThisUser
                    ? Alignment.centerRight
                    : AlignmentGeometry.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 4.0 + (isNextMsgOwnerDifferent ? 8 : 0),
                  ),
                  child:
                      DecoratedBox(
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
                          boxShadow: [
                            const BoxShadow(
                              blurRadius: 16,
                              offset: Offset(0, 4),
                              color: Color(0x26000000),
                            ),
                          ],
                          color: isSentByThisUser
                              ? Color(0xFFE94F11)
                              : Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  widget.chatMessages.messages[index].message,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: isSentByThisUser
                                        ? Colors.white
                                        : Color(0xFF212121),
                                  ),
                                ),
                              ),
                              8.verticalSpace,
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: isSentByThisUser
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  if (isSentByThisUser)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 2.0,
                                        right: 3,
                                      ),
                                      child: AnimatedSwitcher(
                                        duration: const Duration(
                                          milliseconds: 250,
                                        ),
                                        child: widget.isOnline
                                            ? AppAssets.icSentRead.displayImage(
                                                color: Colors.white,
                                                height: 18,
                                                width: 18,
                                              )
                                            : AppAssets.icSent.displayImage(
                                                color: Colors.white,
                                                height: 18,
                                                width: 18,
                                              ),
                                      ),
                                    ),
                                  Flexible(
                                    child: Text(
                                      widget
                                          .chatMessages
                                          .messages[index]
                                          .sentAt
                                          .formatSentTime,
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: isSentByThisUser
                                            ? Colors.white
                                            : Color(0xFF7033E9),
                                      ),
                                    ),
                                  ),
                                  if (!isSentByThisUser)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 2.0,
                                        left: 3,
                                      ),
                                      child: AnimatedSwitcher(
                                        duration: const Duration(
                                          milliseconds: 250,
                                        ),
                                        child: widget.hasNewMessages
                                            ? AppAssets.icSent.displayImage(
                                                color: Color(0xFF7033E9),
                                                height: 18,
                                                width: 18,
                                              )
                                            : AppAssets.icSentRead.displayImage(
                                                color: Color(0xFF7033E9),
                                                height: 18,
                                                width: 18,
                                              ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ).wrapWithDownToUpAnimation(
                        delayFactor: delayFactor(2, index + 2),
                      ),
                ),
              );
            }, childCount: widget.chatMessages.messages.length),
          ),
        ),
      ),
    );
  }
}
