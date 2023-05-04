import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/data_provider/box_manager.dart';
import '../../domain/entity/group.dart';
import '../../domain/entity/task.dart';

class TasksUpdateCubit extends Cubit<List<Task>>{
  TasksUpdateCubit() : super([]);
    int groupKey = 0;
    var taskText='';
    var tasks = <Task>[];


  void navigateBack(BuildContext context){
    context.router.pop();
  }

  initFirstState() async{
    final taskBox = await BoxManager.instance.openTaskBox(groupKey);
    tasks = taskBox.values.toList();
    emit(tasks.toList());
  }

  void saveTask(BuildContext context) async{
    if (taskText.isEmpty) return;
    final taskBox = await BoxManager.instance.openTaskBox(groupKey);
    final task = Task(text: taskText, isDone: false);
    await taskBox.add(task);
    tasks = taskBox.values.toList();
    emit(tasks.toList());  // важный момент без .toList() emit не происходил
    navigateBack(context);
    }

    void deleteTask(int taskIndex) async{
      final taskBox = await BoxManager.instance.openTaskBox(groupKey);
      await taskBox.deleteAt(taskIndex);
      tasks = taskBox.values.toList();
      emit(tasks.toList());
    }

    void doneToggle(int taskIndex, bool? checkBoxToggle) async{
      final taskBox = await BoxManager.instance.openTaskBox(groupKey);
      final task = taskBox.getAt(taskIndex);
      task?.isDone = !task.isDone;
      await task?.save();
      tasks = taskBox.values.toList();
      emit(tasks.toList());
    }
}

/*
class TasksUpdateCubit extends Cubit<List<Task>>{
  TasksUpdateCubit() : super([]);
  int groupKey = 0;
  var taskText='';
  var tasks = <Task>[];


  void navigateBack(BuildContext context){
    context.router.pop();
  }

  initFirstState() async{
    if(!Hive.isAdapterRegistered(2)){
      Hive.registerAdapter(TaskAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final taskBox = await Hive.openBox<Task>('tasks_box');
    final groupBox = await Hive.openBox<Group>('groups_box');
    final group = groupBox.get(groupKey);
    tasks = group?.tasks ?? <Task>[];
    emit(tasks.toList());
    print('initFirstStateinitFirstStateinitFirstStateinitFirstStateinitFirstStateinitFirstState');
  }

  void saveTask(BuildContext context) async{
    if (taskText.isEmpty) return;
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final taskBox = await Hive.openBox<Task>('tasks_box');
    final task = Task(text: taskText, isDone: false);
    await taskBox.add(task);

    final groupBox = await Hive.openBox<Group>('groups_box');
    final group = groupBox.get(groupKey);
    group?.addTask(taskBox, task);

    tasks = group?.tasks ?? <Task>[];
    emit(tasks.toList());  // важный момент без .toList() emit не происходил
    navigateBack(context);
  }

  void deleteTask(int index) async{
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final taskBox = await Hive.openBox<Task>('tasks_box');
    final groupBox = await Hive.openBox<Group>('groups_box');
    final group = groupBox.get(groupKey);
    group?.tasks?.deleteFromHive(index);
    tasks = group?.tasks ?? <Task>[];

    emit(tasks.toList());
  }

  void doneToggle(int index, bool? checkBoxToggle) async{
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final taskBox = await Hive.openBox<Task>('tasks_box');
    final groupBox = await Hive.openBox<Group>('groups_box');
    final group = groupBox.get(groupKey);
    group?.tasks?[index].isDone = checkBoxToggle ?? false;
    group?.tasks?[index].save();
    tasks = group?.tasks ?? <Task>[];

    emit(tasks.toList());
  }
}*/


