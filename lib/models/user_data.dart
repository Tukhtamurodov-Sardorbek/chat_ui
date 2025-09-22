import 'package:flutter/foundation.dart';

@immutable
class UserData {
  final int id;
  final String name;
  final String positionTitle;
  final bool isOnline;
  final String profileImage;

  const UserData({
    required this.id,
    required this.name,
    required this.positionTitle,
    required this.isOnline,
    required this.profileImage,
  });

  UserData copyWith({
    int?
    id, // Just to create other users with the help of copyWith method [for automation mock data generation]
    String? name,
    String? positionTitle,
    bool? isOnline,
    String? profileImage,
  }) {
    return UserData(
      id: id ?? this.id,
      name: name ?? this.name,
      positionTitle: positionTitle ?? this.positionTitle,
      isOnline: isOnline ?? this.isOnline,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
