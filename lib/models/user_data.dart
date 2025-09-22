import 'package:flutter/foundation.dart';

@immutable
class UserData {
  final int id;
  final String name;
  final String positionTitle;
  final UserStatus status;
  final String profileImage;

  const UserData({
    required this.id,
    required this.name,
    required this.positionTitle,
    required this.status,
    required this.profileImage,
  });

  UserData copyWith({
    int?
    id, // Just to create other users with the help of copyWith method [for automation mock data generation]
    String? name,
    String? positionTitle,
    UserStatus? status,
    String? profileImage,
  }) {
    return UserData(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      positionTitle: positionTitle ?? this.positionTitle,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

sealed class UserStatus {
  const UserStatus._();

  const factory UserStatus.online() = _Online;

  const factory UserStatus.typing() = _Typing;

  const factory UserStatus.lastSeenRecently(DateTime? date) = _LastSeenRecently;

  bool get isOnline => when(
    online: () => true,
    typing: () => true,
    lastSeenRecently: (_) => false,
  );

  T when<T>({
    required T Function() online,
    required T Function() typing,
    required T Function(DateTime?) lastSeenRecently,
  }) {
    return switch (this) {
      _Online() => online(),
      _Typing() => typing(),
      _LastSeenRecently(:final lastActiveSession) => lastSeenRecently(
        lastActiveSession,
      ),
    };
  }
}

final class _Online extends UserStatus {
  const _Online() : super._();
}

final class _LastSeenRecently extends UserStatus {
  final DateTime? lastActiveSession;

  const _LastSeenRecently(this.lastActiveSession) : super._();
}

final class _Typing extends UserStatus {
  const _Typing() : super._();
}
