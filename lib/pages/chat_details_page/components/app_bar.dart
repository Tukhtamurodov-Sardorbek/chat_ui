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
  _AppBar(
    BuildContext context, {
    super.key,
    required String image,
    required bool isOnline,
    required String name,
    required String status,
  }) : super(
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
             CircularUserProfileImage(
               imageSize: 40,
               image: image,
               isOnline: isOnline,
             ),
             12.horizontalSpace,
             Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: [
                   Text(
                     name,
                     style: TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.w700,
                       color: Color(0xFF212121),
                     ),
                   ),
                   4.verticalSpace,
                   Text(
                     status,
                     style: TextStyle(
                       fontSize: 12,
                       fontWeight: FontWeight.w500,
                       color: Color(0xFF838997),
                     ),
                   ),
                 ],
               ),
             ),
           ],
         ),
         actions: [AppAssets.icTrash.displayIconButton(size: 20, onTap: () {})],
       );
}
