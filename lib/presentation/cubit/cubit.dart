import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/domain/data_provider/box_manager.dart';
import 'package:todo_list/presentation/cubit/makeGroupsListCubit.dart';
import 'package:todo_list/presentation/cubit/tasksUpdateCubit.dart';

import '../../domain/entity/group.dart';
import '../../domain/entity/task.dart';
import '../../providers/routes/routes.gr.dart';
/*
class UpdateCubit extends Cubit<List>{
  UpdateCubit() : super([]);
  var groupName = '';
  var tasks = <Task>[];
  //var groups = <Group>[];
 // var groupsNew = <Group>[];




  void navigateBack(BuildContext context){
    context.router.pop();
  }

  void initFirstState() async{
    if(!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    emit(box.values.toList());
  }


  void saveGroup(BuildContext context, MakeGroupsListCubit makeGroupsListCubit, UpdateCubit updateCubit) async{
      if(groupName.isEmpty) return;
      if(!Hive.isAdapterRegistered(1)){
        Hive.registerAdapter(GroupAdapter());
      }
      final box = await Hive.openBox<Group>('groups_box');
      final group = Group(name: groupName);
      await box.add(group);
      emit(box.values.toList());
      makeGroupsListCubit.makeList(); // раньше не было
      navigateBack(context);
  }

  void deleteGroup(int index, MakeGroupsListCubit makeGroupsListCubit, UpdateCubit updateCubit) async{
    if(!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    await box.deleteAt(index);
    makeGroupsListCubit.makeList();
    emit(box.values.toList());
  }

  Future<int> specialForKey(int groupIndex) async{
    final box = await Hive.openBox<Group>('groups_box');
    final groupKey = box.keyAt(groupIndex) as int;
    return groupKey;
  }


  void showTasksWidget(BuildContext context, int groupIndex, UpdateCubit updateCubit, TasksUpdateCubit tasksUpdateCubit) async{
    final box = await Hive.openBox<Group>('groups_box');
    final groupKey = box.keyAt(groupIndex) as int;
     context.router.push(TasksWidgetRouter(updateCubit: updateCubit, groupKey: groupKey, tasksUpdateCubit: tasksUpdateCubit, index: groupIndex));
   }

}
*/



class UpdateCubit extends Cubit<List>{
  UpdateCubit() : super([]);
  var groupName = '';
  //var tasks = <Task>[];
  var groups = <Group>[];

  void navigateBack(BuildContext context){
    context.router.pop();
  }

  void initAmountOfGroup(MakeGroupsListCubit makeGroupsListCubit) async{
    final box = await BoxManager.instance.openGroupBox();
    groups = box.values.toList();
    makeGroupsListCubit.getAmountOfGroups(groups);
    //emit(box.values.toList());
  }


  void initGroupState() async{
    final box = await BoxManager.instance.openGroupBox();
    groups = box.values.toList();
    emit(box.values.toList());
  }

  void saveGroup(BuildContext context, MakeGroupsListCubit makeGroupsListCubit, UpdateCubit updateCubit) async{
    if(groupName.isEmpty) return;
    final box = await BoxManager.instance.openGroupBox();
    final group = Group(name: groupName);
    await box.add(group);
    emit(box.values.toList());
    initGroupState();
    navigateBack(context);
  }

  void deleteGroup(int groupIndex, MakeGroupsListCubit makeGroupsListCubit, UpdateCubit updateCubit) async{
    final box = await BoxManager.instance.openGroupBox();
    final groupKey = box.keyAt(groupIndex) as int;
    final taskBoxName = BoxManager.instance.makeTaskBoxName(groupKey);
    await Hive.deleteBoxFromDisk(taskBoxName);
    await box.deleteAt(groupIndex); //deleteAt
    initGroupState();
    emit(box.values.toList());
  }

  void renameGroup(int index , String textFromCon, MakeGroupsListCubit makeGroupsListCubit) async{
    final groupBox = await BoxManager.instance.openGroupBox();
    final group = groupBox.getAt(index);
    group?.name = textFromCon;
    group?.save();
    groups = groupBox.values.toList();
    emit(groups.toList());
  }

  void showTasksWidget(BuildContext context, int groupIndex, UpdateCubit updateCubit, TasksUpdateCubit tasksUpdateCubit) async{
    final box = await BoxManager.instance.openGroupBox();
    final groupKey = box.keyAt(groupIndex) as int;
    context.router.push(TasksWidgetRouter(updateCubit: updateCubit, groupKey: groupKey, tasksUpdateCubit: tasksUpdateCubit, index: groupIndex));
  }

}