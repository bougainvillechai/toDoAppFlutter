import 'package:hive_flutter/hive_flutter.dart';

class toDoDatabase {
  List todoList = [];
  //reference the box
  final _myBox = Hive.box('myBox');
  //if the first time to ever open this app
  void createInitalApp() {
    todoList = [
      ["Make Bed", false],
      ["Eat Healthy", false]
    ];
  }

  //load the data form the database
  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  void updateData() {
    _myBox.put("TODOLIST", todoList);
  }
}
