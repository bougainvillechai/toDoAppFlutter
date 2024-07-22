import 'package:hive_flutter/hive_flutter.dart';

class toDoDatabase {
  List todoList = [];
  //reference the box
  final _myBox = Hive.openBox('myBox');
}
