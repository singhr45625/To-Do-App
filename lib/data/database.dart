import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{

  List toDoList = [];

  // reference hive box

  final _myBox = Hive.box('myBox');

  // if user opening the app first time

   void createInitialData() {
     toDoList = [
       ["Make a app", false],
       ["Do exercise", false],
     ];
   }

   void loadData() {
      toDoList = _myBox.get("TODOLIST");
   }
   
   void updateData() {
     _myBox.put("TODOLIST", toDoList);
   }
}