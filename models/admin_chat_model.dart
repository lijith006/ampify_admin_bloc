//------------------------------------------------
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatMessage {
//   final String senderId;
//   final String senderName;
//   final String senderEmail;
//   final String? senderBase64Image;
//   final String text;
//   final DateTime timestamp;
//   final bool isSeen;

//   ChatMessage({
//     required this.senderId,
//     required this.senderName,
//     required this.senderEmail,
//     this.senderBase64Image,
//     required this.text,
//     required this.timestamp,
//     required this.isSeen,
//   });

//   /// Convert to Firestore map, using a server timestamp if desired
//   Map<String, dynamic> toMap({bool useServerTimestamp = false}) {
//     return {
//       'senderId': senderId,
//       'senderName': senderName,
//       'senderEmail': senderEmail,
//       'senderBase64Image': senderBase64Image,
//       'text': text,
//       // either use client-side DateTime…
//       'timestamp': useServerTimestamp
//           ? FieldValue.serverTimestamp()
//           : Timestamp.fromDate(timestamp),
//       'isSeen': isSeen,
//     };
//   }

//   /// Build from Firestore data—expects a Timestamp in `map['timestamp']`
//   factory ChatMessage.fromMap(Map<String, dynamic> map) {
//     final rawTs = map['timestamp'];
//     DateTime parsedTs;

//     if (rawTs is Timestamp) {
//       parsedTs = rawTs.toDate();
//     } else if (rawTs is Map && rawTs['_seconds'] != null) {
//       // Sometimes serverTimestamp undone returns a map
//       parsedTs = DateTime.fromMillisecondsSinceEpoch(
//           rawTs['_seconds'] * 1000 + (rawTs['_nanoseconds'] ~/ 1000000));
//     } else {
//       parsedTs = DateTime.now();
//     }

//     return ChatMessage(
//       senderId: map['senderId'] ?? '',
//       senderName: map['senderName'] ?? '',
//       senderEmail: map['senderEmail'] ?? '',
//       senderBase64Image: map['senderBase64Image'],
//       text: map['text'] ?? '',
//       timestamp: parsedTs,
//       isSeen: map['isSeen'] ?? false,
//     );
//   }
// }
//---------------------------------------------
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String senderId;
  final String senderName;
  final String senderEmail;
  final String? senderBase64Image;
  final String text;
  final DateTime timestamp;
  final bool isSeen;

  ChatMessage({
    required this.senderId,
    required this.senderName,
    required this.senderEmail,
    this.senderBase64Image,
    required this.text,
    required this.timestamp,
    required this.isSeen,
  });

  /// Always write a true Firestore Timestamp
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'senderEmail': senderEmail,
      'senderBase64Image': senderBase64Image,
      'text': text,
      'timestamp': Timestamp.fromDate(timestamp),
      'isSeen': isSeen,
    };
  }

  /// Read either a Timestamp or (legacy) a String
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    final raw = map['timestamp'];
    DateTime parsed;

    if (raw is Timestamp) {
      parsed = raw.toDate();
    } else if (raw is String) {
      parsed = DateTime.tryParse(raw) ?? DateTime.now();
    } else {
      parsed = DateTime.now();
    }

    return ChatMessage(
      senderId: map['senderId'] ?? '',
      senderName: map['senderName'] ?? '',
      senderEmail: map['senderEmail'] ?? '',
      senderBase64Image: map['senderBase64Image'],
      text: map['text'] ?? '',
      timestamp: parsed,
      isSeen: map['isSeen'] ?? false,
    );
  }
}
