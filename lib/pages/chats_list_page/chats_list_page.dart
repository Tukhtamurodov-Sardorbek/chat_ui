import 'package:chat_ui/core/assets/app_assets.dart';
import 'package:chat_ui/core/controller/controller.dart';
import 'package:chat_ui/pages/chats_list_page/component/list_tile/list_tile.dart';
import 'package:chat_ui/core/extensions/list_ext.dart';
import 'package:chat_ui/core/extensions/num_ext.dart';
import 'package:chat_ui/core/widgets/vertical_animation_item_wrapper.dart';
import 'package:chat_ui/models/chat_data.dart';
import 'package:chat_ui/models/user_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'component/state_mixin.dart';

part 'component/inheritedData.dart';

part 'component/tab_bar_views/mock_bar_view.dart';

final ChatsController chatController = ChatsController();

class ChatsListPage extends StatefulWidget {
  const ChatsListPage({super.key});

  @override
  State<ChatsListPage> createState() => _ChatsListPageState();
}

class _ChatsListPageState extends State<ChatsListPage>
    with SingleTickerProviderStateMixin, _StateHelper {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(listener);

    Future.delayed(const Duration(milliseconds: 800), () {
      chatController.initMockData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _MyInheritedWidget(
      state: this,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Chat',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF212121),
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Teachers'),
              Tab(text: 'Group'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _MockBarView(key: ValueKey(1)),
            _MockBarView(key: ValueKey(2)),
          ],
        ),
      ),
    );
  }
}
