part of '../chats_list_page.dart';

mixin _StateHelper on State<ChatsListPage> {
  late final TabController _tabController;


  void listener() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.removeListener(listener);
    _tabController.dispose();
  }
}
