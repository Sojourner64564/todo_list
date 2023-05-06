import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/presentation/cubit/cubit.dart';
import 'package:todo_list/presentation/cubit/makeGroupsListCubit.dart';
import '../../domain/data_provider/box_manager.dart';
import '../../domain/entity/group.dart';
import '../../domain/entity/task.dart';

class TasksUpdateCubit extends Cubit<List<Task>>{
  TasksUpdateCubit() : super([]);
    int groupKey = 0;
    //int groupKeyForGroupWidget = 0;
   // int indexForGroups = 0;
    var taskText='';
    var tasks = <Task>[];
    var newTasks = <Task>[];
    int groups=0;
    String? firstTask;
    var firstTasks = <String>[];


  void navigateBack(BuildContext context){
    context.router.pop();
  }

  initFirstState() async{
    final taskBox = await BoxManager.instance.openTaskBox(groupKey);
    tasks = taskBox.values.toList();
    emit(tasks.toList());
  }


  void saveTask(BuildContext context, MakeGroupsListCubit makeGroupsListCubit, UpdateCubit updateCubit) async{
    if (taskText.isEmpty) return;
    final taskBox = await BoxManager.instance.openTaskBox(groupKey);
    final task = Task(text: taskText, isDone: false);
    await taskBox.add(task);
    tasks = taskBox.values.toList();
    updateCubit.initAmountOfGroup(makeGroupsListCubit);
    emit(tasks.toList());  // важный момент без .toList() emit не происходил
    navigateBack(context);
    }

    void deleteTask(int taskIndex, MakeGroupsListCubit makeGroupsListCubit, UpdateCubit updateCubit) async{
      final taskBox = await BoxManager.instance.openTaskBox(groupKey);
      await taskBox.deleteAt(taskIndex);
      tasks = taskBox.values.toList();
      updateCubit.initAmountOfGroup(makeGroupsListCubit);
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


