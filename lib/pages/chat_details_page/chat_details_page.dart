import 'dart:async';

import 'package:chat_ui/core/assets/app_assets.dart';
import 'package:chat_ui/core/extensions/date_time_ext.dart';
import 'package:chat_ui/core/extensions/list_ext.dart';
import 'package:chat_ui/core/extensions/num_ext.dart';
import 'package:chat_ui/core/extensions/string_ext.dart';
import 'package:chat_ui/core/widgets/circular_user_profile_image.dart';
import 'package:chat_ui/core/widgets/sticky_header/widget.dart';
import 'package:chat_ui/core/widgets/vertical_animation_item_wrapper.dart';
import 'package:chat_ui/models/chat_data.dart';
import 'package:chat_ui/models/user_data.dart';
import 'package:chat_ui/pages/chats_list_page/chats_list_page.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

part 'components/app_bar.dart';

part 'components/state_mixin.dart';

part 'components/sticky_header.dart';

class ChatDetailsPage extends StatefulWidget {
  final UserData chatterData;

  const ChatDetailsPage({super.key, required this.chatterData});

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();

  // // Static method to access the state from descendant widgets
  // static _ChatDetailsPageState of(BuildContext context) {
  //   final state = context.findAncestorStateOfType<_ChatDetailsPageState>();
  //   assert(
  //     state != null,
  //     'No ChatDetailsPage ancestor found in the widget tree',
  //   );
  //   return state!;
  // }
}

class _ChatDetailsPageState extends State<ChatDetailsPage> with _StateHelper {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(
        context,
        image: widget.chatterData.profileImage,
        isOnline: widget.chatterData.status.isOnline,
        name: widget.chatterData.name,
        status: widget.chatterData.status.when(
          online: () => 'Online',
          typing: () => 'Typing message...',
          lastSeenRecently: (date) => date.formatLastSeen,
        ),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          AnimatedBuilder(
            animation: chatController,
            builder: (context, _) {
              final thisChat = chatController.chats.firstWhereOrNull(
                (ch) => ch.otherUserId == widget.chatterData.id,
              );
              if (thisChat == null) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return MultiSliver(
                children: List.generate(thisChat.messages.length, (index) {
                  return _SliverStickyHeaderView(
                    isFirst: index == 0,
                    chatMessages: thisChat.messages[index],
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
