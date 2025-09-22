import 'package:chat_ui/core/extensions/date_time_ext.dart';
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

  factory ChatData.empty(int otherUserId) {
    return ChatData(otherUserId: otherUserId, messages: const []);
  }

  ChatData get readAll {
    return ChatData(
      otherUserId: otherUserId,
      messages: messages,
      newMessages: [],
    );
  }

  ChatData addNewMessages(
    List<ChatMessages> newMessages, {
    bool clearAfterMerge = true,
  }) {
    final updatedMessages = List<ChatMessages>.from(messages);

    for (final newMsg in newMessages) {
      final existingIndex = updatedMessages.indexWhere(
        (m) => m.date.isSameDate(newMsg.date),
      );

      if (existingIndex != -1) {
        final existing = updatedMessages[existingIndex];
        updatedMessages[existingIndex] = ChatMessages(
          date: existing.date,
          messages: [...existing.messages, ...newMsg.messages],
        );
      } else {
        updatedMessages.add(newMsg);
      }
    }

    updatedMessages.sort((a, b) => a.date.compareTo(b.date));

    return ChatData(
      otherUserId: otherUserId,
      messages: updatedMessages,
      newMessages: clearAfterMerge ? [] : newMessages,
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
  final bool isRead;

  bool get isSentByThisUser => ownerId == chatController.thisUser.id;

  const ChatMessageData({
    required this.ownerId,
    required this.sentAt,
    required this.message,
    this.isRead = true,
  });
}
