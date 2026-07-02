import 'package:cloud_firestore/cloud_firestore.dart';

/// A note stored in Cloud Firestore, scoped to a single user.
class Note {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String userId;

  const Note({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.userId,
  });

  /// Build a [Note] from a Firestore document snapshot.
  factory Note.fromMap(String id, Map<String, dynamic> data) {
    return Note(
      id: id,
      title: (data['title'] ?? '') as String,
      description: (data['description'] ?? '') as String,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      userId: (data['userId'] ?? '') as String,
    );
  }

  /// Serialize this note for Firestore.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
      'userId': userId,
    };
  }

  Note copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    String? userId,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }
}
