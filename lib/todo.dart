class Todo {
  late int id;
  late String title;
  late String detail;
  late bool isDone;
  late String createDate;
  late String updateDate;

  /// constructor
  Todo(
    this.id,
    this.title,
    this.detail,
    this.isDone,
    this.createDate,
    this.updateDate,
  );

  /// Todoモデル => Map 変換する
  Map toJson() {
    return {
      'id': id,
      'title': title,
      'detail': detail,
      'done': isDone,
      'createDate': createDate,
      'updateDate': updateDate
    };
  }

  /// Map => Todoモデル 変換する
  Todo.fromJson(Map json) {
    id = json['id'];
    title = json['title'];
    detail = json['detail'];
    isDone = json['done'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
  }
}
