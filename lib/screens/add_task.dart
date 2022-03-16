import 'package:flutter/material.dart';
import 'package:todo_app/home.dart';
import 'package:todo_app/module/todoModule.dart';
import 'package:todo_app/util/sqlitManager.dart';

class add_task extends StatefulWidget {
  const add_task({Key? key}) : super(key: key);

  @override
  State<add_task> createState() => _add_taskState();
}

class _add_taskState extends State<add_task> {
  SqlDb sqlDb = SqlDb();
  TextEditingController _controller = TextEditingController();
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
                  var todo = Todo({'title': _controller.text, 'done': 0});
                  int response = await sqlDb.insertData(todo);
                  if (response > 0) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => home()));
                  }
                },
                child: Text('Add task'),
              )
            ],
          )),
    );
  }
}
