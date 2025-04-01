// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:timeline_tile/timeline_tile.dart';

// class OrderTimeline extends StatelessWidget {
//   final String status;
//   final bool isFirst;
//   final bool isLast;
//   final bool isActive;
//   final IconData icon;
//   final String description;
//   final String animationPath;
//   const OrderTimeline({
//     Key? key,
//     required this.status,
//     this.isFirst = false,
//     this.isLast = false,
//     this.isActive = false,
//     required this.icon,
//     required this.description,
//     required this.animationPath,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TimelineTile(
//       alignment: TimelineAlign.manual,
//       lineXY: 0.1,
//       isFirst: isFirst,
//       isLast: isLast,
//       beforeLineStyle: LineStyle(
//         color: isActive ? Colors.black54 : Colors.grey[300]!,
//         thickness: 2,
//       ),
//       afterLineStyle: LineStyle(
//         color: isActive ? Colors.black54 : Colors.grey[300]!,
//         thickness: 2,
//       ),
//       indicatorStyle: IndicatorStyle(
//         width: 20,
//         color: isActive ? Colors.black87 : Colors.grey[300]!,
//         iconStyle: IconStyle(
//           iconData: icon,
//           color: Colors.white,
//         ),
//       ),
//       endChild: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               status,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: isActive ? Colors.black87 : Colors.grey[300]!,
//                 fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               description,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//             if (isActive)
//               Lottie.asset(
//                 animationPath,
//                 width: 100,
//                 height: 100,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//******************************************************************** */
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:timeline_tile/timeline_tile.dart';

// class OrderTimeline extends StatelessWidget {
//   final String status;
//   final bool isFirst;
//   final bool isLast;
//   final bool isActive;
//   final IconData icon;
//   final String description;
//   final String animationPath;
//   final VoidCallback? onTap;
//   const OrderTimeline({
//     Key? key,
//     required this.status,
//     this.isFirst = false,
//     this.isLast = false,
//     this.isActive = false,
//     required this.icon,
//     required this.description,
//     required this.animationPath,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TimelineTile(
//       alignment: TimelineAlign.manual,
//       lineXY: 0.1,
//       isFirst: isFirst,
//       isLast: isLast,
//       beforeLineStyle: LineStyle(
//         color: isActive ? Colors.black54 : Colors.grey[300]!,
//         thickness: 2,
//       ),
//       afterLineStyle: LineStyle(
//         color: isActive ? Colors.black54 : Colors.grey[300]!,
//         thickness: 2,
//       ),
//       indicatorStyle: IndicatorStyle(
//         width: 20,
//         color: isActive ? Colors.black87 : Colors.grey[300]!,
//         iconStyle: IconStyle(
//           iconData: icon,
//           color: Colors.white,
//         ),
//       ),
//       endChild: GestureDetector(
//         onTap: onTap,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 status,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: isActive ? Colors.black87 : Colors.grey[300]!,
//                   fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 description,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               if (isActive)
//                 Lottie.asset(
//                   animationPath,
//                   width: 100,
//                   height: 100,
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//00000000000000000000000000000000000000000

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:timeline_tile/timeline_tile.dart';
// import 'package:lottie/lottie.dart';
// import 'package:timeline_tile/timeline_tile.dart';

class OrderTimeline extends StatelessWidget {
  final String status;
  final bool isFirst;
  final bool isLast;
  final bool isActive;
  final IconData icon;
  final String description;
  final String animationPath;
  final VoidCallback? onTap;
  final Widget? trailing;

  const OrderTimeline({
    Key? key,
    required this.status,
    this.isFirst = false,
    this.isLast = false,
    this.isActive = false,
    required this.icon,
    required this.description,
    required this.animationPath,
    this.onTap,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(
        color: isActive ? Colors.black54 : Colors.grey[300]!,
        thickness: 2,
      ),
      afterLineStyle: LineStyle(
        color: isActive ? Colors.black54 : Colors.grey[300]!,
        thickness: 2,
      ),
      indicatorStyle: IndicatorStyle(
        width: 20,
        color: isActive ? Colors.black87 : Colors.grey[300]!,
        iconStyle: IconStyle(
          iconData: icon,
          color: Colors.white,
        ),
      ),
      endChild: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 16,
                        color: isActive ? Colors.black87 : Colors.grey[300]!,
                        fontWeight:
                            isActive ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (isActive)
                      Lottie.asset(
                        animationPath,
                        width: 100,
                        height: 100,
                      ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
