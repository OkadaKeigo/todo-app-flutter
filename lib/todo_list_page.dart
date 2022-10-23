import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/todo_input_page.dart';
import 'package:todo_app/todo_list_store.dart';

///
class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

///
class _TodoListPageState extends State<TodoListPage> {
  final TodoListStore _store = TodoListStore();

  /// TodoInputPageへ遷移
  void _pushTodoInputPage([Todo? todo]) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return TodoInputPage(todo: todo);
    }));

    /// 画面の更新
    setState(() {});
  }

  /// 初期処理
  @override
  void initState() {
    super.initState();

    Future(() async {
      setState(() => _store.load());
    });
  }

  /// 画面
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: ListView.builder(
        // Todoの件数 = リストの件数
        itemCount: _store.count(),
        itemBuilder: (context, index) {
          Todo item = _store.findByIndex(index);
          return Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                    onPressed: (context) {
                      _pushTodoInputPage(item);
                    },
                    backgroundColor: Colors.yellow,
                    icon: Icons.edit,
                    label: '編集'),
              ],
            ),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  onPressed: (context) {
                    setState(() => {_store.delete(item)});
                  },
                  backgroundColor: Colors.red,
                  icon: Icons.edit,
                  label: '削除',
                ),
              ],
            ),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: ListTile(
                leading: Text(item.id.toString()),
                title: Text(item.title),
                trailing: Checkbox(
                  value: item.isDone,
                  onChanged: (bool? value) {
                    setState(() => _store.update(item, value!));
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushTodoInputPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}