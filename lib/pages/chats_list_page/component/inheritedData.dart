part of '../chats_list_page.dart';

class _MyInheritedWidget extends InheritedWidget {
  final _ChatsListPageState state;

  const _MyInheritedWidget({required super.child, required this.state});

  @override
  bool updateShouldNotify(_MyInheritedWidget old) {
    return false;
  }
}
