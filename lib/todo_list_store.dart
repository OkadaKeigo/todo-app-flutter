import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'todo.dart';

class TodoListStore {
  // 保存時のキー
  final String _saveKey = 'Todo';

  List<Todo> _list = [];

  // Storeのインスタンス生成
  static final TodoListStore _instance = TodoListStore._();

  // Private constructor
  TodoListStore._();

  // Factory constructor
  factory TodoListStore() {
    return _instance;
  }

  int count() {
    return _list.length;
  }

  Todo findByIndex(int index) {
    return _list[index];
  }

  String getDateTime() {
    DateFormat format = DateFormat('yyyy/MM/dd HH:mm');
    String dateTime = format.format(DateTime.now());
    return dateTime;
  }

  void add(bool isDone, String title, String detail) {
    int id = count() == 0 ? 1 : _list.last.id + 1;
    String dateTime = getDateTime();
    var todo = Todo(id, title, detail, isDone, dateTime, dateTime);
    _list.add(todo);
    save();
  }

  void update(Todo todo, bool isDone, [String? title, String? detail]) {
    todo.isDone = isDone;
    if (title != null) {
      todo.title = title;
    }
    if (detail != null) {
      todo.detail = detail;
    }
    todo.updateDate = getDateTime();
    save();
  }

  void delete(Todo todo) {
    _list.remove(todo);
    save();
  }

  void save() async {
    var prefs = await SharedPreferences.getInstance();
    // SharedPreferencesはプリミティブ型とString型リストしか扱えないため、以下の変換を行っている
    // TodoList形式 → Map形式 → JSON形式 → List<String>形式
    var saveTargetList = _list.map((a) => json.encode(a.toJson())).toList();
    prefs.setStringList(_saveKey, saveTargetList);
  }

  void load() async {
    var prefs = await SharedPreferences.getInstance();
    var loadTargetList = prefs.getStringList(_saveKey) ?? [];
    _list = loadTargetList.map((a) => Todo.fromJson(json.decode(a))).toList();
  }
}
