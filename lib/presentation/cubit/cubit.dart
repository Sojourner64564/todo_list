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
    initAmountOfGroup(makeGroupsListCubit);
    navigateBack(context);
  }

  void deleteGroup(int groupIndex, MakeGroupsListCubit makeGroupsListCubit, UpdateCubit updateCubit) async{
    final box = await BoxManager.instance.openGroupBox();
    final groupKey = box.keyAt(groupIndex) as int;
    final taskBoxName = BoxManager.instance.makeTaskBoxName(groupKey);
    await Hive.deleteBoxFromDisk(taskBoxName);
    await box.deleteAt(groupIndex); //deleteAt
    initGroupState();
    initAmountOfGroup(makeGroupsListCubit);
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

  void showTasksWidget(BuildContext context, int groupIndex, UpdateCubit updateCubit, TasksUpdateCubit tasksUpdateCubit, MakeGroupsListCubit makeGroupsListCubit) async{
    final box = await BoxManager.instance.openGroupBox();
    final groupKey = box.keyAt(groupIndex) as int;
    context.router.push(TasksWidgetRouter(updateCubit: updateCubit, groupKey: groupKey, tasksUpdateCubit: tasksUpdateCubit, index: groupIndex, makeGroupsListCubit:makeGroupsListCubit));
  }

}