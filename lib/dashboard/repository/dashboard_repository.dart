import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/dashboard/model/todo.dart';

class DashboardRepository {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<Either<String, List<Todo>>> fetchTodos() async {
    try {
      final todosReference = await FirebaseFirestore.instance
          .collection("Users")
          .doc("user1")
          .collection("todos");
      final _todosQuerySnapshot = await todosReference.get();
      final _todosDocumentSnapshotList = _todosQuerySnapshot.docs;
      _todos.clear();
      final _todosList = _todosDocumentSnapshotList.map(
        (e) {
          return Todo.fromJson(json: e.data(), docId: e.id);
        },
      );
      for (final item in _todosList) {
        _todos.add(item);
        // print(item.data());
      }
      return Right(_todos);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Todo>>> createTodo({String? title}) async {
    try {
      final todosReference = await FirebaseFirestore.instance
          .collection("Users")
          .doc("user1")
          .collection("todos");
      final newTodoReference = await todosReference.add({
        "title": title,
        "createdAt": Timestamp.now(),
      });
      await newTodoReference.set(
        {"docId": newTodoReference.id},
        SetOptions(merge: true),
      );
      final _todoSnapshot = await newTodoReference.get();
      final _todo = Todo.fromJson(
          json: _todoSnapshot.data()!, docId: newTodoReference.id);
      _todos.add(_todo);

      return Right(_todos);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Todo>>> updateTodo(
      {required String? docId, required String? title}) async {
    try {
      final todosReference = FirebaseFirestore.instance
          .collection("Users")
          .doc("user1")
          .collection("todos");

      final documentReference = todosReference.doc(docId);

      final documentSnapshot = await documentReference.get();

      final initialTitle = documentSnapshot.data()!["title"];

      await documentReference.set(
        {"title": title},
        SetOptions(merge: true),
      );

      final index = _todos.indexWhere(
        (e) => e.title == initialTitle,
      );
      if (index != -1) {
        _todos[index].title = title;
      }

      return Right(_todos);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Todo>>> deleteTodo(
      {required String? docId}) async {
    try {
      final todosReference = FirebaseFirestore.instance
          .collection("Users")
          .doc("user1")
          .collection("todos");
      final docRef = todosReference.doc(docId);
      final docSnapshot = await docRef.get();
      final title = docSnapshot.data()!["title"];

      await docRef.delete();

      final index = _todos.indexWhere(
        (e) => e.title == title,
      );
      if (index != -1) {
        _todos.removeAt(index);
      }

      return Right(_todos);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Todo>>> refresh() async {
    try {
      return Right(_todos);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
