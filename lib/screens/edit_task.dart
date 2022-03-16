import 'package:flutter/material.dart';
import 'package:todo_app/home.dart';
import 'package:todo_app/module/todoModule.dart';
import 'package:todo_app/util/sqlitManager.dart';

class edit_task extends StatefulWidget {
  final id;
  final title;
  final done;
  const edit_task(
      {Key? key, required this.id, required this.title, required this.done})
      : super(key: key);

  @override
  State<edit_task> createState() => _edit_taskState();
}

class _edit_taskState extends State<edit_task> {
  SqlDb sqlDb = SqlDb();
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    _controller.text = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Task'),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  var todo = Todo({
                    'id': widget.id,
                    'title': _controller.text,
                    'done': widget.done
                  });
                  int response = await sqlDb.updateData(todo, widget.id);
                  if (response > 0) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => home()));
                  }
                },
                child: Text('Edit task'),
              )
            ],
          )),
    );
  }
}
