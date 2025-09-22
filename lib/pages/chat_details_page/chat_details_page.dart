import 'dart:async';

import 'package:chat_ui/core/assets/app_assets.dart';
import 'package:chat_ui/core/extensions/date_time_ext.dart';
import 'package:chat_ui/core/extensions/list_ext.dart';
import 'package:chat_ui/core/extensions/num_ext.dart';
import 'package:chat_ui/core/extensions/string_ext.dart';
import 'package:chat_ui/core/extensions/widget_ext.dart';
import 'package:chat_ui/core/widgets/circular_user_profile_image.dart';
import 'package:chat_ui/core/widgets/down_to_up_animation.dart';
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
}

class _ChatDetailsPageState extends State<ChatDetailsPage> with _StateHelper {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _AppBar(context, chatterData: widget.chatterData),
      body: Column(
        children: [
          Flexible(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              slivers: [
                AnimatedBuilder(
                  animation: chatController,
                  builder: (context, _) {
                    final chatter = chatController.users.firstWhereOrNull(
                      (u) => u.id == widget.chatterData.id,
                    );
                    final thisChat = chatController.chats.firstWhereOrNull(
                      (ch) => ch.otherUserId == widget.chatterData.id,
                    );
                    if (thisChat == null) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (thisChat.messages.isEmpty) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(child: Text('No message yet')),
                      );
                    }
                    return MultiSliver(
                      children: List.generate(thisChat.messages.length, (
                        index,
                      ) {
                        return _SliverStickyHeaderView(
                          position: index,
                          isOnline: chatter!.status.isOnline,
                          chatMessages: thisChat.messages[index],
                          hasNewMessages: thisChat.newMessages.isNotEmpty,
                        );
                      }),
                    );
                  },
                ),
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                const BoxShadow(
                  blurRadius: 24,
                  offset: Offset(0, -20),
                  color: Color(0xA000000),
                ),
              ],
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: SafeArea(
              minimum: EdgeInsets.fromLTRB(12, 14, 12, 16),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: "Write here",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.2,
                      color: Color(0xFFE9E9E9),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(42.0)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.2,
                      color: Color(0xFFE9E9E9),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(42.0)),
                  ),
                  suffixIconConstraints: BoxConstraints.tight(Size(54, 54)),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: AlignmentGeometry.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.2, 1.0],
                          tileMode: TileMode.decal,
                          colors: [Color(0xFF4500D9), Color(0xFFAB145A)],
                        ),
                      ),
                      child: AppAssets.icSendButton.displayIconButton(
                        onTap: _sendMessage,
                      ),
                    ),
                  ),
                ),
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                onTap: () {
                  Future.delayed(const Duration(milliseconds: 300), () {
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
