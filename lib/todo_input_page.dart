import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/todo_list_store.dart';

class TodoInputPage extends StatefulWidget {
  final Todo? todo;

  const TodoInputPage({Key? key, this.todo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodoInputPageState();
}

class _TodoInputPageState extends State<TodoInputPage> {
  /// store
  final TodoListStore _store = TodoListStore();

  static const String emptyText = "";

  /// 新規追加か否か
  late bool _isCreateTodo;

  late String _title;
  late String _detail;
  late bool _isDone;
  late String _createDate;
  late String _updateDate;

  /// 初期処理
  @override
  void initState() {
    super.initState();
    Todo? todo = widget.todo;

    _title = todo?.title ?? emptyText;
    _detail = todo?.detail ?? emptyText;
    _isDone = todo?.isDone ?? false;
    _createDate = todo?.createDate ?? emptyText;
    _updateDate = todo?.updateDate ?? emptyText;
    _isCreateTodo = todo == null;
  }

  /// 画面
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appbar
      appBar: AppBar(
        title: Text(_isCreateTodo ? 'Todo追加' : 'Todo更新'),
      ),
      /// body
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            /// チェックボックス
            CheckboxListTile(
                title: const Text("完了"),
                value: _isDone,
                onChanged: (bool? value) {
                  setState(() {
                    _isDone = value ?? false;
                  });
                }),
            const SizedBox(
              height: 20,
            ),

            /// title
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "タイトル",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              controller: TextEditingController(text: _title),
              onChanged: (String value) {
                _title = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),

            /// detail
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 3,
              decoration: const InputDecoration(
                labelText: "詳細",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              controller: TextEditingController(text: _detail),
              onChanged: (String value) {
                _detail = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),

            /// 追加・更新ボタン
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_isCreateTodo) {
                    _store.add(_isDone, _title, _detail);
                  } else {
                    _store.update(widget.todo!, _isDone, _title, _detail);
                  }
                  Navigator.of(context).pop();
                },
                child: Text(
                  _isCreateTodo ? '追加' : '更新',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            /// キャンセルボタン
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.blue),
                ),
                child: const Text(
                  'キャンセル',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text('作成日時：$_createDate'),
            Text('作成日時：$_updateDate'),
          ],
        ),
      ),
    );
  }
}
