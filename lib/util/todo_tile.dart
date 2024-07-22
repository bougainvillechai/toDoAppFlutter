import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class toDoList extends StatelessWidget {
  const toDoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Make it to remote job!!",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
