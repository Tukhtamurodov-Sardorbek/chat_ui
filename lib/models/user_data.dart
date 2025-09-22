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

  const factory UserStatus.online(bool typing) = _Online;

  const factory UserStatus.offline(DateTime? date) = _Offline;

  bool get isOnline => when(online: (_) => true, offline: (_) => false);

  bool get isTyping => when(online: (typing) => typing, offline: (_) => false);

  T when<T>({
    required T Function(bool) online,
    required T Function(DateTime?) offline,
  }) {
    return switch (this) {
      _Online(:final isTyping) => online(isTyping),
      _Offline(:final lastActiveSession) => offline(lastActiveSession),
    };
  }
}

final class _Online extends UserStatus {
  final bool isTyping;

  const _Online(this.isTyping) : super._();
}

final class _Offline extends UserStatus {
  final DateTime? lastActiveSession;

  const _Offline(this.lastActiveSession) : super._();
}
