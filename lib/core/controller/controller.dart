import 'package:chat_ui/core/assets/app_assets.dart';
import 'package:chat_ui/models/chat_data.dart';
import 'package:chat_ui/models/user_data.dart';
import 'package:flutter/foundation.dart';

class ChatsController extends ChangeNotifier {
  UserData? _data;
  int _mockId = -1;
  int _newMessagedUsersCount = 0;

  late final UserData _thisUser;
  List<UserData> _users = [];
  List<ChatData> _chats = [];

  UserData get thisUser => _thisUser;

  List<UserData> get users => List.unmodifiable(_users);

  List<ChatData> get chats => List.unmodifiable(_chats);

  ChatsController();

  void initMockData() {
    _thisUser = UserData(
      id: 1000,
      name: 'Sam',
      positionTitle: 'Student',
      status: UserStatus.online(),
      profileImage: AppAssets.mockUserThumbnail,
    );

    _users.addAll([
      _constructMockUser(),
      _constructMockUser(
        name: 'Mirshakar',
        positionTitle: 'Teacher',
        status: UserStatus.typing(),
      ),
      _constructMockUser(
        name: 'Oybek',
        positionTitle: 'Support teacher',
        status: UserStatus.lastSeenRecently(null),
      ),
      _constructMockUser(
        name: 'Jasur',
        positionTitle: 'Teacher',
        status: UserStatus.online(),
      ),
      _constructMockUser(
        name: 'Sherzod',
        positionTitle: 'Support teacher',
        status: UserStatus.lastSeenRecently(
          DateTime.now().subtract(const Duration(hours: 2)),
        ),
      ),
      _constructMockUser(
        name: 'Jamshid',
        positionTitle: 'Teacher',
        status: UserStatus.lastSeenRecently(
          DateTime.now().subtract(const Duration(minutes: 1)),
        ),
      ),
      _constructMockUser(
        name: 'Xurshid',
        positionTitle: 'Teacher',
        status: UserStatus.lastSeenRecently(
          DateTime.now().subtract(const Duration(minutes: 15)),
        ),
      ),
    ]);

    final others = _users.where((u) => u.id != _thisUser.id).toList();
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

    _chats.addAll(messages);
    _chats.sort((a, b) => b.newMessages.length.compareTo(a.newMessages.length));

    notifyListeners();
  }

  List<ChatMessages> _constructMockMessages(UserData otherUser) {
    return [
      ChatMessages(
        date: DateTime.now().subtract(const Duration(days: 2)),
        messages: [
          ChatMessageData(
            ownerId: _thisUser.id,
            sentAt: DateTime.now().subtract(const Duration(hours: 48)),
            message: 'Hi ${otherUser.name}!',
          ),
          ChatMessageData(
            ownerId: _thisUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 47, minutes: 58),
            ),
            message: 'It\'s me, ${_thisUser.name}. How are you doing?',
          ),
        ],
      ),
      ChatMessages(
        date: DateTime.now().subtract(const Duration(days: 1)),
        messages: [
          ChatMessageData(
            ownerId: otherUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 23, minutes: 34),
            ),
            message:
                'Oh ${_thisUser.name}, how are you man? I\'m doing well btw',
          ),
          ChatMessageData(
            ownerId: _thisUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 23, minutes: 33),
            ),
            message: 'Nice, I got some good news for you...',
          ),
          ChatMessageData(
            ownerId: otherUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 23, minutes: 32),
            ),
            message: 'Really? Now you got me curious 👀',
          ),
          ChatMessageData(
            ownerId: otherUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 23, minutes: 32),
            ),
            message: 'What happened?',
          ),
          ChatMessageData(
            ownerId: _thisUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 23, minutes: 28),
            ),
            message: 'Haha, I\'d rather tell you in person.',
          ),
          ChatMessageData(
            ownerId: _thisUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 23, minutes: 27),
            ),
            message:
                'Let\'s catch up somewhere tomorrow, I\'ll share everything then.',
          ),
          ChatMessageData(
            ownerId: otherUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 23, minutes: 27),
            ),
            message: 'Sounds good! Let\'s meet at our usual café',
          ),
          ChatMessageData(
            ownerId: _thisUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 23, minutes: 26),
            ),
            message: 'Perfect, can’t wait to tell you!',
          ),
        ],
      ),
    ];
  }

  List<ChatMessages> _constructMockNewMessages(UserData otherUser) {
    return _newMessagedUsersCount.isEven
        ? [
            ChatMessages(
              date: DateTime.now(),
              messages: [
                ChatMessageData(
                  ownerId: otherUser.id,
                  sentAt: DateTime.now().subtract(const Duration(hours: 2)),
                  message: 'Saturday afternoon works?',
                ),
                ChatMessageData(
                  ownerId: otherUser.id,
                  sentAt: DateTime.now().subtract(
                    const Duration(hours: 1, minutes: 59),
                  ),
                  message: 'I could use a break and some good company ☕️',
                ),
              ],
            ),
          ]
        : [
            ChatMessages(
              date: DateTime.now(),
              messages: [
                ChatMessageData(
                  ownerId: otherUser.id,
                  sentAt: DateTime.now().subtract(const Duration(hours: 2)),
                  message:
                      'By the way, do you still order that caramel latte every time? 😄',
                ),
                ChatMessageData(
                  ownerId: otherUser.id,
                  sentAt: DateTime.now().subtract(
                    const Duration(hours: 1, minutes: 59),
                  ),
                  message: 'I’ll grab us a good table before you arrive!',
                ),
                ChatMessageData(
                  ownerId: otherUser.id,
                  sentAt: DateTime.now().subtract(const Duration(minutes: 2)),
                  message: 'Oh, and don’t be late this time 😅',
                ),
                ChatMessageData(
                  ownerId: otherUser.id,
                  sentAt: DateTime.now().subtract(const Duration(minutes: 2)),
                  message:
                      'I’m bringing something for you too, kind of a surprise 😉',
                ),
              ],
            ),
          ];
  }

  UserData _constructMockUser({
    String? name,
    String? positionTitle,
    UserStatus? status,
  }) {
    _mockId += 1;
    _data ??= UserData(
      id: _mockId,
      name: 'Sardorbek Qosimov',
      positionTitle: 'Support teacher',
      status: UserStatus.online(),
      profileImage: AppAssets.mockUserThumbnail,
    );

    return _data!.copyWith(
      id: _mockId,
      name: name,
      status: status,
      positionTitle: positionTitle,
    );
  }

  bool alterChatterStatus(UserData otherUser) {
    final index = _users.indexWhere((u) => u.id == otherUser.id);
    if (index == -1) return false;

    final user = _users[index];
    if (!user.status.isOnline) return false;

    _users[index] = user.status.when(
      online: () => user.copyWith(status: UserStatus.typing()),
      typing: () => user.copyWith(status: UserStatus.online()),
      lastSeenRecently: (_) =>
          user, // Though this will never happen thanks to isOnline check
    );

    notifyListeners();

    return true;
  }

  void sendMessage(
    UserData otherUser,
    String message, {
    bool isSentByThisUser = false,
  }) {
    final chatIndex = _chats.indexWhere((c) => c.otherUserId == otherUser.id);
    if (chatIndex == -1) return;

    final chat = _chats[chatIndex].addNewMessages([
      ChatMessages(
        date: DateTime.now(),
        messages: [
          ChatMessageData(
            message: message,
            sentAt: DateTime.now(),
            ownerId: isSentByThisUser ? _thisUser.id : otherUser.id,
          ),
        ],
      ),
    ]);

    _chats[chatIndex] = chat;
    notifyListeners();
  }
}

/*

mixin _StateHelper on State<ChatsListPage> {
  int _mockId = -1;
  UserData? _data;
  int _newMessagedUsersCount = 0;
  late final UserData _thisUser;
  late final ValueNotifier<List<UserData>> _mockUsers;
  late final ValueNotifier<List<ChatData>> _mockChats;
  late final TabController _tabController;

  UserData get thisUser => _thisUser;

  ValueNotifier<List<UserData>> get mockUsers => _mockUsers;

  ValueNotifier<List<ChatData>> get mockChats => _mockChats;

  void _initMockData() {
    _thisUser = UserData(
      id: 1000,
      name: 'Sam',
      positionTitle: 'Student',
      status: UserStatus.online(),
      profileImage: AppAssets.mockUserThumbnail,
    );
    _mockUsers.value = List.from(<UserData>[
      _constructMockUser(),
      _constructMockUser(
        name: 'Mirshakar',
        positionTitle: 'Teacher',
        status: UserStatus.typing(),
      ),
      _constructMockUser(
        name: 'Oybek',
        positionTitle: 'Support teacher',
        status: UserStatus.lastSeenRecently(null),
      ),
      _constructMockUser(
        name: 'Jasur',
        positionTitle: 'Teacher',
        status: UserStatus.online(),
      ),
      _constructMockUser(
        name: 'Sherzod',
        positionTitle: 'Support teacher',
        status: UserStatus.lastSeenRecently(
          DateTime.now().subtract(Duration(hours: 2)),
        ),
      ),
      _constructMockUser(
        name: 'Jamshid',
        positionTitle: 'Teacher',
        status: UserStatus.lastSeenRecently(
          DateTime.now().subtract(Duration(minutes: 1)),
        ),
      ),
      _constructMockUser(
        name: 'Xurshid',
        positionTitle: 'Teacher',
        status: UserStatus.lastSeenRecently(
          DateTime.now().subtract(Duration(minutes: 15)),
        ),
      ),
    ]);

    final others = _mockUsers.value.where((u) => u.id != _thisUser.id).toList();
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
    final temp = List.from([..._mockChats.value, ...messages]);
    temp.sort((a, b) => b.newMessages.length.compareTo(a.newMessages.length));
    _mockChats.value = List.from(temp);
  }

  List<ChatMessages> _constructMockMessages(UserData otherUser) {
    return [
      ChatMessages(
        date: DateTime.now().subtract(const Duration(days: 2)),
        messages: [
          ChatMessageData(
            ownerId: _thisUser.id,
            sentAt: DateTime.now().subtract(const Duration(hours: 48)),
            messages: 'Hi ${otherUser.name}!',
          ),
          ChatMessageData(
            ownerId: _thisUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 47, minutes: 58),
            ),
            messages: 'It\'s me, ${_thisUser.name}. How are you doing?',
          ),
        ],
      ),
      ChatMessages(
        date: DateTime.now().subtract(const Duration(days: 1)),
        messages: [
          ChatMessageData(
            ownerId: otherUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 23, minutes: 34),
            ),
            messages:
                'Oh ${_thisUser.name}, how are you man? I\'m doing well btw',
          ),
          ChatMessageData(
            ownerId: _thisUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 23, minutes: 33),
            ),
            messages: 'Nice, I got some good news for you...',
          ),
          ChatMessageData(
            ownerId: otherUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 23, minutes: 32),
            ),
            messages: 'Really? Now you got me curious 👀',
          ),
          ChatMessageData(
            ownerId: otherUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 23, minutes: 32),
            ),
            messages: 'What happened?',
          ),
          ChatMessageData(
            ownerId: _thisUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 23, minutes: 28),
            ),
            messages: 'Haha, I\'d rather tell you in person.',
          ),
          ChatMessageData(
            ownerId: _thisUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 23, minutes: 27),
            ),
            messages:
                'Let\'s catch up somewhere tomorrow, I\'ll share everything then.',
          ),
          ChatMessageData(
            ownerId: otherUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 23, minutes: 27),
            ),
            messages: 'Sounds good! Let\'s meet at our usual café',
          ),
          ChatMessageData(
            ownerId: _thisUser.id,
            sentAt: DateTime.now().subtract(
              const Duration(hours: 23, minutes: 26),
            ),
            messages: 'Perfect, can’t wait to tell you!',
          ),
        ],
      ),
    ];
  }

  List<ChatMessages> _constructMockNewMessages(UserData otherUser) {
    return _newMessagedUsersCount.isEven
        ? [
            ChatMessages(
              date: DateTime.now(),
              messages: [
                ChatMessageData(
                  ownerId: otherUser.id,
                  sentAt: DateTime.now().subtract(const Duration(hours: 2)),
                  messages: 'Saturday afternoon works?',
                ),
                ChatMessageData(
                  ownerId: otherUser.id,
                  sentAt: DateTime.now().subtract(
                    const Duration(hours: 1, minutes: 59),
                  ),
                  messages: 'I could use a break and some good company ☕️',
                ),
              ],
            ),
          ]
        : [
            ChatMessages(
              date: DateTime.now(),
              messages: [
                ChatMessageData(
                  ownerId: otherUser.id,
                  sentAt: DateTime.now().subtract(const Duration(hours: 2)),
                  messages:
                      'By the way, do you still order that caramel latte every time? 😄',
                ),
                ChatMessageData(
                  ownerId: otherUser.id,
                  sentAt: DateTime.now().subtract(
                    const Duration(hours: 1, minutes: 59),
                  ),
                  messages: 'I’ll grab us a good table before you arrive!',
                ),
                ChatMessageData(
                  ownerId: otherUser.id,
                  sentAt: DateTime.now().subtract(const Duration(minutes: 2)),
                  messages: 'Oh, and don’t be late this time 😅',
                ),
                ChatMessageData(
                  ownerId: otherUser.id,
                  sentAt: DateTime.now().subtract(const Duration(minutes: 2)),
                  messages:
                      'I’m bringing something for you too, kind of a surprise 😉',
                ),
              ],
            ),
          ];
  }

  UserData _constructMockUser({
    String? name,
    String? positionTitle,
    UserStatus? status,
  }) {
    _mockId += 1;
    _data ??= UserData(
      id: _mockId,
      name: 'Sardorbek Qosimov',
      positionTitle: 'Support teacher',
      status: UserStatus.online(),
      profileImage: AppAssets.mockUserThumbnail,
    );

    return _data!.copyWith(
      id: _mockId,
      name: name,
      status: status,
      positionTitle: positionTitle,
    );
  }

  void listener() {
    setState(() {});
  }

  bool alterChatterStatus(UserData otherUser) {
    final isChatterOnline =
        _mockUsers.value.getPropertyOfFirstWhereOrNull(
          (user) => user.id == otherUser.id,
          getProperty: (user) => user.status.isOnline,
        ) ??
        false;
    if (!isChatterOnline) return false;

    final tempUsers = <UserData>[];
    for (final user in _mockUsers.value) {
      if (user.id == otherUser.id) {
        user.status.when(
          online: () {
            tempUsers.add(user.copyWith(status: UserStatus.typing()));
          },
          typing: () {
            tempUsers.add(user.copyWith(status: UserStatus.online()));
          },
          lastSeenRecently: (_) {
            // Though this will never happen thanks to isChatterOnline
            tempUsers.add(user);
          },
        );
      } else {
        tempUsers.add(user);
      }
    }
    _mockUsers.value = List.from(tempUsers);
    return true;
  }

  void sendMessage(
    UserData otherUser,
    String messages, {
    bool isSentByThisUser = false,
  }) {
    final List<ChatData> _tempChats = [];
    for (var chat in _mockChats.value) {
      if (chat.otherUserId == otherUser.id) {
        _tempChats.add(
          chat.addNewMessages([
            ChatMessages(
              date: DateTime.now(),
              messages: [
                ChatMessageData(
                  messages: messages,
                  sentAt: DateTime.now(),
                  ownerId: isSentByThisUser ? _thisUser.id : otherUser.id,
                ),
              ],
            ),
          ]),
        );
      } else {
        _tempChats.add(chat);
      }
    }

    _mockChats.value = List.from(_tempChats);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.removeListener(listener);
    _tabController.dispose();
    _mockChats.dispose();
    _mockUsers.dispose();
  }
}
 */
