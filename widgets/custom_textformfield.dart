// import 'package:flutter/material.dart';

// class Customtextformfield extends StatelessWidget {
//   final TextEditingController controller;
//   final String labelText;
//   final bool obscureText;
//   final String? Function(String?)? validator;

//   const Customtextformfield(
//       {super.key,
//       required this.controller,
//       required this.labelText,
//       this.obscureText = false,
//       this.validator});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//           labelText: labelText,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//           )),
//       validator: validator,
//     );
//   }
// }
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final int maxLines;

  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: suffixIcon),
      validator: validator,
    );
  }
}
