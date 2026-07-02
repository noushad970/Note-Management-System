import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/note.dart';

/// CRUD operations on a user's notes in Cloud Firestore.
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Notes collection for a given user.
  CollectionReference<Map<String, dynamic>> _notesCollection(String userId) {
    return _db.collection('users').doc(userId).collection('notes');
  }

  /// Live stream of the user's notes, newest first.
  Stream<List<Note>> getNotesStream(String userId) {
    return _notesCollection(userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Note.fromMap(doc.id, doc.data()))
            .toList());
  }

  /// Create a new note. The Firestore-assigned id is ignored; the model
  /// just carries the user payload.
  Future<DocumentReference<Map<String, dynamic>>> addNote(Note note) {
    return _notesCollection(note.userId).add(note.toMap());
  }

  /// Update an existing note.
  Future<void> updateNote(Note note) {
    return _notesCollection(note.userId).doc(note.id).update(note.toMap());
  }

  /// Delete a note by id.
  Future<void> deleteNote(String userId, String noteId) {
    return _notesCollection(userId).doc(noteId).delete();
  }
}
