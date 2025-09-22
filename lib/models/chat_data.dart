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
  final int ownerId;
  final List<String> messages;

  const ChatMessages({required this.ownerId, required this.messages});

  ChatMessages copyWith({List<String>? messages}) {
    return ChatMessages(ownerId: ownerId, messages: messages ?? this.messages);
  }
}
