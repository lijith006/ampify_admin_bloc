// import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   final Widget? prefixIcon;
//   final String label;
//   final VoidCallback onTap;
//   //final Color color;
//   final double borderRadius;

//   const CustomButton(
//       {super.key,
//       required this.label,
//       required this.onTap,
//       // this.color = const Color(0xFF323340),

//       this.borderRadius = 30.0,
//       this.prefixIcon});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(borderRadius),
//         splashColor: Colors.tealAccent.withOpacity(0.5),
//         child: Container(
//           margin: const EdgeInsets.all(10),
//           width: double.infinity,
//           alignment: Alignment.center,
//           padding: const EdgeInsets.symmetric(
//             horizontal: 24,
//             vertical: 15,
//           ),
//           decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Colors.orangeAccent, Colors.orange],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               // color: color,
//               borderRadius: BorderRadius.circular(
//                 borderRadius,
//               ),
//               boxShadow: const [
//                 BoxShadow(
//                     color: Colors.black,
//                     spreadRadius: 3,
//                     blurRadius: 7,
//                     offset: Offset(0, 3)),
//               ]),
//           child: Text(
//             label,
//             style: const TextStyle(
//                 color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }
// }
//******************************************************************************************************* */
//attempt 2 //

// import 'dart:ui';

// import 'package:flutter/material.dart';

// class CustomButton extends StatefulWidget {
//   final Widget? prefixIcon;
//   final String label;
//   final VoidCallback onTap;
//   final double borderRadius;

//   final bool isLoading;
//   final Color? borderColor;
//   final double blurStrength;

//   const CustomButton({
//     super.key,
//     required this.label,
//     required this.onTap,
//     this.prefixIcon,
//     this.borderRadius = 50.0,
//     this.isLoading = false,
//     this.borderColor,
//     this.blurStrength = 10.0,
//   });

//   @override
//   State<CustomButton> createState() => _CustomButtonState();
// }

// class _CustomButtonState extends State<CustomButton> {
//   bool _isPressed = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) => setState(() => _isPressed = true), // Button press
//       onTapUp: (_) {
//         setState(() => _isPressed = false); // Button release
//         widget.onTap();
//       },
//       onTapCancel: () => setState(() => _isPressed = false), // Cancel state
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         curve: Curves.easeInOut,
//         transform: _isPressed
//             ? Matrix4.translationValues(0, 2, 0) // Pressed "down" effect
//             : Matrix4.identity(),
//         decoration: BoxDecoration(
//           color: const Color(0xFF31473A),
//           borderRadius: BorderRadius.circular(widget.borderRadius),
//           border: widget.borderColor != null
//               ? Border.all(color: widget.borderColor!, width: 1.5)
//               : null,
//           //   // Background color
//           boxShadow: _isPressed
//               ? [
//                   // Slight inset shadow on press
//                   // const BoxShadow(
//                   //   color: Colors.black12,
//                   //   // offset: Offset(2, 2),
//                   //   blurRadius: 5,
//                   // ),
//                 ]
//               : [
//                   // Default neumorphic shadow
//                   // const BoxShadow(
//                   //   color: Colors.white,
//                   //   offset: Offset(-3, -3),
//                   //   blurRadius: 5,
//                   // ),
//                   // const BoxShadow(
//                   //   color: Colors.black12,
//                   //   offset: Offset(3, 3),
//                   //   blurRadius: 5,
//                   // ),
//                 ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(widget.borderRadius),
//           child: Center(
//             child: Container(
//               width: double.infinity,
//               height: 50,
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: widget.isLoading
//                     ? [
//                         const SizedBox(
//                           width: 20,
//                           height: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor: AlwaysStoppedAnimation(Colors.white),
//                           ),
//                         ),
//                       ]
//                     : [
//                         if (widget.prefixIcon != null) ...[
//                           widget.prefixIcon!,
//                           const SizedBox(width: 8),
//                         ],
//                         Text(
//                           widget.label,
//                           style: TextStyle(
//                             color: Colors.grey.shade700,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       //   ),
//     );
//   }
// }

//************************************************************************************************************ */
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Widget? prefixIcon;
  final String label;
  final VoidCallback onTap;
  final double borderRadius;
  final bool isLoading;
  final Color? borderColor;
  final double blurStrength;
  final double? width; //  button width
  final double height; //  button height

  const CustomButton({
    super.key,
    required this.label,
    required this.onTap,
    this.prefixIcon,
    this.borderRadius = 50.0,
    this.isLoading = false,
    this.borderColor,
    this.blurStrength = 10.0,
    this.width, // Custom width
    this.height = 60.0, // Default height
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: _isPressed
            ? Matrix4.translationValues(0, 2, 0)
            : Matrix4.identity(),
        width: widget.width ??
            MediaQuery.of(context).size.width * 0.9, // Adjustable width
        height: widget.height, // Adjustable height
        decoration: BoxDecoration(
          color: const Color(0xFF31473A),
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: widget.borderColor != null
              ? Border.all(color: widget.borderColor!, width: 1.5)
              : null,
        ),
        child: Center(
          child: Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.isLoading
                  ? [
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                    ]
                  : [
                      if (widget.prefixIcon != null) ...[
                        widget.prefixIcon!,
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.label,
                        style: const TextStyle(
                          color: Color(0xFFEDF4F2),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
            ),
          ),
        ),
      ),
    );
  }
}
