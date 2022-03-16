class Todo {
  int? _id;
  late String _title;
  late int _done;

  Todo(dynamic obj) {
    _id = obj['id'];
    _title = obj['title'];
    _done = obj['done'];
  }

  Todo.fromMap(Map<String, dynamic> data) {
    _id = data['id'];
    _title = data['title'];
    _done = data['done'];
  }

  Map<String, dynamic> toMap() => {'id': _id, 'title': _title, 'done': _done};

  int? get id => _id;
  String get title => _title;
  int get done => _done;
}
