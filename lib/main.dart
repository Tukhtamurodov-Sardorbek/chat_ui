import 'package:chat_ui/pages/chats_list_page/chats_list_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Chat UI',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFFF5F5F5)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ChatsListPage(),
    ),
  );
}
