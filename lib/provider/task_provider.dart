import 'package:flutter/material.dart';
import 'package:myapp/models/task_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TaskProvider extends ChangeNotifier {
  final db = FirebaseFirestore.instance;
  List<Task> tasks = [];

  // Load tasks
  Future<void> load() async {
    try {
      final snapshot = await db.collection('tasks').get();

      tasks = snapshot.docs.map((doc) => Task(
        id: doc.id,
        title: doc['title'] ?? '',
        completed: doc['completed'] ?? false,
      )).toList();

      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  // Add task
  Future<void> addTask(String title) async {
    try {
      if (title.trim().isEmpty) return;

      final ref = await db.collection('tasks').add({
        'title': title,
        'completed': false,
        'timestamp': FieldValue.serverTimestamp(),
      });

      tasks.add(Task(
        id: ref.id,
        title: title,
        completed: false,
      ));

      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }
}

Future<void> update(Task tasks) async {

  try{
    //delete task from Firestore using index
    await db.collection('tasks').doc(tasks[i].id).update({completed: completed})
     tasks[i] = Task(id: tasks[i].id, title: tasks[i].title, completed: completed);
     notifyListeners();
  }catch(e){
    print('Error: $e')
    }
}

Future<void> delete(int i) async {
  try{
    await db.collection('tasks').doc(tasks[i].id).delete();
    tasks.removeAt(i);
    notifyListeners();
  }catch(e){
    print('Error: $e')
    )
}
