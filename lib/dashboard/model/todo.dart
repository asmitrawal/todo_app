// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String? title;
  final String? docId;
  final Timestamp? createdAt;
  bool? completed;

  Todo({
    required this.title,
    required this.docId,
    required this.createdAt,
    required this.completed,
  });

  factory Todo.fromJson({
    required Map<String, dynamic> json,
    required String docId,
  }) {
    return Todo(
      title: json["title"],
      docId: docId,
      createdAt: json["createdAt"],
      completed: json["completed"],
    );
  }

  Todo copywith({String? title}) {
    return Todo(
      title: title ?? this.title,
      docId: docId ?? this.docId,
      createdAt: createdAt ?? this.createdAt,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "docId": this.docId,
      "createdAt": this.createdAt,
      "completed": this.completed,
    };
  }
}
