part of '../chats_list_page.dart';

class MyInheritedWidget extends InheritedWidget {
  final UserData thisUser;
  final List<UserData> mockUsers;
  final List<ChatData> mockChats;

  const MyInheritedWidget({
    super.key,
    required super.child,
    required this.thisUser,
    required this.mockUsers,
    required this.mockChats,
  });

  static MyInheritedWidget of(BuildContext context) {
    final MyInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
    assert(result != null, 'No MyInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(MyInheritedWidget old) {
    return listEquals(old.mockChats, mockChats) == false ||
        listEquals(old.mockUsers, mockUsers) == false;
  }
}
