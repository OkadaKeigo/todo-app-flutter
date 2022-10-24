import 'package:flutter/material.dart';
import 'package:todo_app/todo_list_page.dart';

/// エントリーポイント
void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  /// コンストラクタ
  const TodoApp({super.key});

  /// UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todoアプリ',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const TodoListPage(),
    );
  }
}
