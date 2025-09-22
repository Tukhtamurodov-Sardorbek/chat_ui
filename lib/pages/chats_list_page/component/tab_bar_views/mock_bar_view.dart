part of '../../chats_list_page.dart';

class _MockBarView extends StatefulWidget {
  const _MockBarView({super.key});

  @override
  State<_MockBarView> createState() => _MockBarViewState();
}

class _MockBarViewState extends State<_MockBarView> {
  @override
  Widget build(BuildContext context) {
    final ref = ChatsListPage.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: CustomScrollView(
        slivers: [
          ValueListenableBuilder(
            valueListenable: ref.mockChats,
            builder: (context, data, _) {
              if (data.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return AnimationLimiter(
                child: SliverList.separated(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ValueListenableBuilder(
                      valueListenable: ref.mockUsers,
                      builder: (context, value, child) {
                        final chatterData = value.firstWhereOrNull(
                          (u) => u.id == data[index].otherUserId,
                        );
                        if (chatterData == null) return SizedBox.shrink();
                        return VerticalAnimationItemWrapper(
                          position: index,
                          child: ChatPreviewTile(chatterData: chatterData),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return 8.verticalSpace;
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
