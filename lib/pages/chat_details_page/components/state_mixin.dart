part of '../chat_details_page.dart';

mixin _StateHelper on State<ChatDetailsPage> {
  late final ScrollController _scrollController;
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _textEditingController = TextEditingController();
  }

  void _sendMessage() {
    final ref = ChatsListPage.of(context);
    bool isChatterOnline = false;
    String message = _textEditingController.text.trim();
    if (message.isEmpty) return;

    ref.sendMessage(widget.chatterData, message, isSentByThisUser: true);

    _textEditingController.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
      Future.delayed(const Duration(milliseconds: 400), () {
        if (context.mounted) {
          isChatterOnline = ref.alterChatterStatus(widget.chatterData);
        }
      });
    });

    // Simulate typing and response delay
    Timer(Duration(seconds: 2), () {
      if (context.mounted && isChatterOnline) {
        ref.alterChatterStatus(widget.chatterData);
        ref.sendMessage(
          widget.chatterData,
          "Your friend's auto-generated reply",
        );

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }
}
