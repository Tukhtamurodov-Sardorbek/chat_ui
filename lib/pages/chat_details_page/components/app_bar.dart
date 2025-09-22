part of '../chat_details_page.dart';

class _AppBar extends AppBar {
  _AppBar(BuildContext context, {super.key})
    : super(
        centerTitle: false,
        leading: SizedBox.square(
          dimension: 36,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE9E9E9)),
            ),
            child: Center(
              child: AppAssets.icArrowBack.displayIconButton(
                size: 20,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            CircularUserProfileImage(
              imageSize: 40,
              image: ChatDetailsPage.of(
                context,
              ).widget.chatterData.profileImage,
              isOnline: ChatDetailsPage.of(
                context,
              ).widget.chatterData.status.isOnline,
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    ChatDetailsPage.of(context).widget.chatterData.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF212121),
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    ChatDetailsPage.of(context).widget.chatterData.status.when(
                      online: () => 'Online',
                      typing: () => 'Typing message...',
                      lastSeenRecently: (date) => _formatLastSeen(date),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF838997),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [AppAssets.icTrash.displayIconButton(size: 20, onTap: () {})],
      );

  static String _formatLastSeen(DateTime? lastOnline) {
    if (lastOnline == null) {
      return 'Last seen recently';
    }

    final now = DateTime.now();
    final difference = now.difference(lastOnline);

    if (difference.inMinutes <= 1) {
      return "Last seen just now";
    } else if (difference.inMinutes < 60) {
      return "Last seen ${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago";
    } else if (difference.inHours < 24) {
      final hours = lastOnline.hour.toString().padLeft(2, '0');
      final minutes = lastOnline.minute.toString().padLeft(2, '0');
      return "Last seen at $hours:$minutes";
    } else if (difference.inDays < 7) {
      return "Last seen ${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago";
    } else {
      return "Last seen on ${lastOnline.day.toString().padLeft(2, '0')}/"
          "${lastOnline.month.toString().padLeft(2, '0')}/"
          "${lastOnline.year}";
    }
  }
}
