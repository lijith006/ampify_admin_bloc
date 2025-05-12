import 'dart:convert';
import 'package:flutter/material.dart';

/// A circular avatar that can display either:
///   a network image (if the string starts with "http")
///   a base64‐decoded image
///  or a fallback icon if neither works.
class AvatarImage extends StatelessWidget {
  final String? imageData;
  final double radius;

  const AvatarImage({
    Key? key,
    required this.imageData,
    this.radius = 20.0,
  }) : super(key: key);

  ImageProvider? _chooseImageProvider(String? data) {
    if (data == null || data.isEmpty) return null;

    if (data.startsWith('http')) {
      return NetworkImage(data);
    } else {
      try {
        final bytes = base64Decode(data);
        return MemoryImage(bytes);
      } catch (_) {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = _chooseImageProvider(imageData);

    return CircleAvatar(
      radius: radius,
      backgroundImage: provider,
      child: provider == null ? Icon(Icons.person, size: radius) : null,
    );
  }
}
