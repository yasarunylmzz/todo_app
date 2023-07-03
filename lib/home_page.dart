import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/todo_tile.dart';
import 'package:todo_app/utility/dialog_box.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  //reference the hive box
  final _myBox = Hive.box('mybox');

  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the 1st time ever openin the app, then creeate default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //there already exists data
      db.loadData();
    }
    super.initState();
  }

  //text controller
  final _controller = TextEditingController();

  //chechkBox was tapped
  void checkBoxChanged(bool value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //save new tasks
  void saveNewTask() {
    setState(() {
      db.toDoList.add([
        _controller.text,
        false,
      ]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  //createNewTask
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            text: 'Enter the Task',
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void settingsTask(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          text: 'Set Task',
          controller: _controller,
          onSave: () {
            setState(() {
              db.toDoList[index][0] = _controller.text; // Değeri güncelle
              _controller.clear();
            });
            Navigator.of(context).pop();
            db.updateDataBase();
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(
            Icons.menu,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                    'https://www.esafety.gov.au/sites/default/files/2019-07/protect_your_personal_information_0.jpg')),
          ),
        ]),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.yellow[200],
      body: Container(
        padding: EdgeInsets.only(bottom: 15, left: 15, top: 10, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBox(),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: db.toDoList.length,
                itemBuilder: (context, index) {
                  return ToDoTile(
                    taskName: db.toDoList[index][0],
                    taskComplete: db.toDoList[index][1],
                    onChanged: (value) => checkBoxChanged(value!, index),
                    deleteFunction: (context) => deleteTask(index),
                    settingsTask: (context) => settingsTask(index),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container SearchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
        ),
      ),
    );
  }
}
