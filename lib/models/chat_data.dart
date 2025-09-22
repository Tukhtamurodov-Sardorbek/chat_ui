import 'package:chat_ui/pages/chats_list_page/chats_list_page.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class ChatData {
  final int otherUserId;
  final List<ChatMessages> messages;
  final List<ChatMessages> newMessages;

  const ChatData({
    required this.otherUserId,
    required this.messages,
    this.newMessages = const [],
  });

  ChatData addNewMessages(List<ChatMessages> newMessages) {
    return ChatData(
      otherUserId: otherUserId,
      newMessages: newMessages,
      messages: List.from([...messages, ...newMessages]),
    );
  }
}

@immutable
class ChatMessages {
  final DateTime date;
  final List<ChatMessageData> messages;

  const ChatMessages({required this.messages, required this.date});

  ChatMessages copyWith({List<ChatMessageData>? messages}) {
    return ChatMessages(date: date, messages: messages ?? this.messages);
  }
}

@immutable
class ChatMessageData {
  final int ownerId;
  final DateTime sentAt;
  final String message;

  bool get isSentByThisUser => ownerId == chatController.thisUser.id;

  const ChatMessageData({
    required this.ownerId,
    required this.sentAt,
    required this.message,
  });
}
