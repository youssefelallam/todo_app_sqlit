import 'package:flutter/material.dart';
import 'package:todo_app/module/todoModule.dart';
import 'package:todo_app/screens/add_task.dart';
import 'package:todo_app/screens/edit_task.dart';
import 'package:todo_app/util/sqlitManager.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('To Do'),
      ),
      body: FutureBuilder(
        future: sqlDb.readData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Todo todo = Todo.fromMap(snapshot.data[index]);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          todo.done > 0
                              ? IconButton(
                                  onPressed: () async {
                                    var todoup = Todo({
                                      'id': todo.id,
                                      'title': todo.title,
                                      'done': 0
                                    });
                                    int response = await sqlDb.updateData(
                                        todoup, todoup.id!);
                                    if (response > 0) {
                                      setState(() {});
                                    }
                                  },
                                  icon: Icon(Icons.check_box),
                                )
                              : IconButton(
                                  onPressed: () async {
                                    var todoup = Todo({
                                      'id': todo.id,
                                      'title': todo.title,
                                      'done': 1
                                    });
                                    int response = await sqlDb.updateData(
                                        todoup, todoup.id!);
                                    if (response > 0) {
                                      setState(() {});
                                    }
                                  },
                                  icon: Icon(Icons.check_box_outline_blank),
                                ),
                          Text(
                            '${todo.title}',
                            style: TextStyle(
                                fontSize: 20,
                                color:
                                    todo.done > 0 ? Colors.grey : Colors.black,
                                decoration: todo.done > 0
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => edit_task(
                                        id: todo.id,
                                        title: todo.title,
                                        done: todo.done,
                                      )));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              int response =
                                  await sqlDb.deleteData('id = ${todo.id}');
                              if (response > 0) {
                                setState(() {});
                              }
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => add_task()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
