part of '../chats_list_page.dart';

mixin _StateHelper on State<ChatsListPage> {
  int _mockId = -1;
  UserData? _data;
  int _newMessagedUsersCount = 0;
  late final UserData _thisUser;
  late final List<UserData> _mockUsers;
  late final List<ChatData> _mockChats;
  late final TabController _tabController;

  void _initMockData() {
    _thisUser = UserData(
      id: 1000,
      name: 'Sam',
      positionTitle: 'Student',
      isOnline: true,
      profileImage: "assets/images/mock_user_thumbnail.png",
    );
    _mockChats = <ChatData>[];
    _mockUsers = [
      _constructMockUser(),
      _constructMockUser(
        name: 'Mirshakar',
        positionTitle: 'Teacher',
        isOnline: false,
      ),
      _constructMockUser(
        name: 'Oybek',
        positionTitle: 'Support teacher',
        isOnline: true,
      ),
      _constructMockUser(
        name: 'Jasur',
        positionTitle: 'Teacher',
        isOnline: true,
      ),
      _constructMockUser(
        name: 'Sherzod',
        positionTitle: 'Support teacher',
        isOnline: true,
      ),
      _constructMockUser(
        name: 'Jamshid',
        positionTitle: 'Teacher',
        isOnline: true,
      ),
      _constructMockUser(
        name: 'Xurshid',
        positionTitle: 'Teacher',
        isOnline: true,
      ),
    ];

    final others = _mockUsers.where((u) => u.id != _thisUser.id).toList();
    final messages = others.map((other) {
      final data = ChatData(
        otherUserId: other.id,
        messages: _constructMockMessages(other),
      );
      if (_newMessagedUsersCount < 3) {
        _newMessagedUsersCount += 1;
        return data.addNewMessages(_constructMockNewMessages(other));
      }
      return data;
    }).toList();
    _mockChats.addAll(messages);
    _mockChats.sort(
      (a, b) => b.newMessages.length.compareTo(a.newMessages.length),
    );
  }

  List<ChatMessages> _constructMockMessages(UserData otherUser) {
    return [
      ChatMessages(
        ownerId: _thisUser.id,
        messages: [
          'Hi ${otherUser.name}!',
          'It\'s me, ${_thisUser.name}. How are you doing?',
        ],
      ),
      ChatMessages(
        ownerId: otherUser.id,
        messages: [
          'Oh ${_thisUser.name}, how are you man? I\'m doing well btw',
        ],
      ),
      ChatMessages(
        ownerId: _thisUser.id,
        messages: ['Nice, I got some good news for you...'],
      ),
      ChatMessages(
        ownerId: otherUser.id,
        messages: ['Really? Now you got me curious 👀', 'What happened?'],
      ),
      ChatMessages(
        ownerId: _thisUser.id,
        messages: [
          'Haha, I\'d rather tell you in person.',
          'Let\'s catch up somewhere this weekend, I\'ll share everything then.',
        ],
      ),
      ChatMessages(
        ownerId: otherUser.id,
        messages: ['Sounds good! Let\'s meet at our usual café'],
      ),
      ChatMessages(
        ownerId: _thisUser.id,
        messages: ['Perfect, can’t wait to tell you!'],
      ),
    ];
  }

  List<ChatMessages> _constructMockNewMessages(UserData otherUser) {
    return _newMessagedUsersCount.isEven
        ? [
            ChatMessages(
              ownerId: otherUser.id,
              messages: [
                'Saturday afternoon works?',
                'I could use a break and some good company ☕️',
              ],
            ),
          ]
        : [
            ChatMessages(
              ownerId: otherUser.id,
              messages: [
                'By the way, do you still order that caramel latte every time? 😄',
                'I’ll grab us a good table before you arrive!',
                'Oh, and don’t be late this time 😅',
                'I’m bringing something for you too, kind of a surprise 😉',
              ],
            ),
          ];
  }

  UserData _constructMockUser({
    String? name,
    String? positionTitle,
    bool? isOnline,
  }) {
    _mockId += 1;
    _data ??= UserData(
      id: _mockId,
      name: 'Sardorbek Qosimov',
      positionTitle: 'Support teacher',
      isOnline: true,
      profileImage: "assets/images/mock_user_thumbnail.png",
    );

    return _data!.copyWith(
      id: _mockId,
      name: name,
      isOnline: isOnline,
      positionTitle: positionTitle,
    );
  }

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
