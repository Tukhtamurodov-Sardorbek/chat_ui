part of '../chat_details_page.dart';

// class _AppBar extends StatelessWidget {
//   final String image;
//   final bool isOnline;
//   final String name;
//   final String status;
//
//   const _AppBar({
//     super.key,
//     required this.image,
//     required this.isOnline,
//     required this.name,
//     required this.status,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: [
//           SizedBox.square(
//             dimension: 36,
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: Color(0xFFE9E9E9), width: 1.4),
//               ),
//               child: Center(
//                 child: AppAssets.icArrowBack.displayIconButton(
//                   size: 20,
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Row(
//               children: [
//                 CircularUserProfileImage(
//                   imageSize: 40,
//                   image: image,
//                   isOnline: isOnline,
//                 ),
//                 12.horizontalSpace,
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         name,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xFF212121),
//                         ),
//                       ),
//                       4.verticalSpace,
//                       Text(
//                         status,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xFF838997),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           AppAssets.icTrash.displayIconButton(size: 20, onTap: () {}),
//         ],
//       ),
//     );
//   }
// }
class _AppBar extends AppBar {
  _AppBar(BuildContext context, {super.key, required UserData chatterData})
    : super(
        centerTitle: false,
        leadingWidth: 56,
        automaticallyImplyLeading: false,
        leading: ColoredBox(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1.3, color: Color(0xFFE9E9E9)),
                ),
                child: AppAssets.icArrowBack.displayIconButton(
                  size: 25,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            AnimatedBuilder(
              animation: chatController,
              builder: (context, _) {
                final data = chatController.users.firstWhereOrNull(
                  (u) => u.id == chatterData.id,
                )!;
                return CircularUserProfileImage(
                  imageSize: 40,
                  image: chatterData.profileImage,
                  isOnline: data.status.isOnline,
                );
              },
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    chatterData.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF212121),
                    ),
                  ),
                  4.verticalSpace,
                  AnimatedBuilder(
                    animation: chatController,
                    builder: (context, _) {
                      final data = chatController.users.firstWhereOrNull(
                        (u) => u.id == chatterData.id,
                      )!;
                      return Text(
                        data.status.when(
                          online: (typing) =>
                              typing ? 'Typing message...' : 'Online',
                          offline: (date) => date.formatLastSeen,
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF838997),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          AppAssets.icTrash.displayIconButton(
            size: 20,
            onTap: () {
              _showClearHistoryDialog(context).then((result) {
                if (result == true) {
                  chatController.cleatHistory(chatterData);
                }
              });
            },
          ),
        ],
      );

  static Future<bool?> _showClearHistoryDialog(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 12),
          backgroundColor: Colors.white,
          shadowColor: Color(0x1F000000),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppAssets.icWarn.displayImage(height: 80, width: 80),
                24.verticalSpace,

                const Text(
                  "Clear history",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF212121),
                  ),
                ),
                12.verticalSpace,

                const Text(
                  "Do you really want to clear the entire history?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF838997),
                  ),
                ),
                24.verticalSpace,

                SizedBox(
                  height: 44,
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: BorderSide(
                              width: 1.2,
                              color: Color(0xFFE9E9E9),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text(
                            "No",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF212121),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE94F11),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text(
                            "Yes",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
