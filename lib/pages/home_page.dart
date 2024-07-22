import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/util/dialog_box.dart';
import 'package:todoapp/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _myBox = Hive.box('myBox');
  final _controller = TextEditingController();
  //todo tasks
  toDoDatabase db = toDoDatabase();

  @override
  void initState() {
    // if this is the first time the app ever
    if (_myBox.get("TODOLIST") == null) {
      db.createInitalApp();
    } else {
      //there already exists data
      db.loadData();
    }
    super.initState();
  }

  void checkBoxValue(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateData();
  }

  void onSave() {
    if (_controller.text.isEmpty) {
//prompt to type something
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a task'),
        ),
      );
    } else {
      setState(() {
        db.todoList.add([_controller.text, false]);
      });
      _controller.clear(); // Clear the text field
      Navigator.of(context).pop();
      db.updateData();
    }
  }

  void onCancel() {
    _controller.clear(); // Clear the text field
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DIalogBox(
            controller: _controller,
            onSave: onSave,
            onCancel: onCancel,
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Center(child: Text('TO DO')),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: db.todoList.length,
            itemBuilder: ((context, index) {
              return toDoList(
                  taskName: db.todoList[index][0],
                  taskCompleted: db.todoList[index][1],
                  onChanged: (value) => checkBoxValue(value, index),
                  deleteFunction: (context) => deleteTask(index));
            })));
  }
}
