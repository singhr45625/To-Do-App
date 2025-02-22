import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/util/DialogBox.dart';
import 'package:todoapp/util/ToDoTile.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  // reference the hive box

  final _myBox = Hive.box('myBox');

  ToDoDataBase db = ToDoDataBase();

  final _controller = TextEditingController();


  @override
  void initState() {

    if(_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    }else {
      db.loadData();
    }
    super.initState();
  }


  // checkbox was tapped
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void saveNextTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void createNewTask()
  {
       showDialog(
           context: context,
           builder: (context) {
            return DialogBox(
              controller: _controller,
              onSave: saveNextTask,
              onCancle: () => Navigator.of(context).pop(),
            );
           },
       );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("To Do"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: createNewTask,
        child: Icon(Icons.add),
          ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return Todotile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },

      ),
    );
  }
}