import 'package:chat_ui/core/extensions/widget_ext.dart';
import 'package:chat_ui/core/widgets/circular_user_profile_image.dart';
import 'package:chat_ui/pages/chat_details_page/chat_details_page.dart';
import 'package:chat_ui/pages/chats_list_page/chats_list_page.dart';
import 'package:chat_ui/core/extensions/list_ext.dart';
import 'package:chat_ui/core/extensions/num_ext.dart';
import 'package:chat_ui/models/user_data.dart';
import 'package:flutter/material.dart';

part 'list_tile_trailing_part.dart';

class ChatPreviewTile extends StatelessWidget {
  final UserData chatterData;

  const ChatPreviewTile({super.key, required this.chatterData});

  static ChatPreviewTile of(BuildContext context) {
    final widget = context.findAncestorWidgetOfExactType<ChatPreviewTile>();
    assert(
      widget != null,
      'No ChatPreviewTile ancestor found in the widget tree',
    );
    return widget!;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularUserProfileImage(
          imageSize: 48,
          image: chatterData.profileImage,
          isOnline: chatterData.status.isOnline,
        ),
        12.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                chatterData.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF212121),
                ),
              ),
              4.verticalSpace,
              Text(
                chatterData.positionTitle,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF838997),
                ),
              ),
            ],
          ),
        ),
        _TrailingView(),
      ],
    ).buttonize(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailsPage(chatterData: chatterData),
          ),
        );
      },
      padding: EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
