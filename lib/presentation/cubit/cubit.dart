import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/presentation/cubit/makeGroupsListCubit.dart';
import 'package:todo_list/presentation/cubit/tasksUpdateCubit.dart';

import '../../domain/entity/group.dart';
import '../../domain/entity/task.dart';
import '../../providers/routes/routes.gr.dart';

class UpdateCubit extends Cubit<List>{
  UpdateCubit() : super([]);
  var groupName = '';
  var tasks = <Task>[];
  var groups = <Group>[];
  var groupsNew = <Group>[];




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



  void showTasksWidget(BuildContext context, int groupIndex, UpdateCubit updateCubit, TasksUpdateCubit tasksUpdateCubit) async{
    final box = await Hive.openBox<Group>('groups_box');
    final groupKey = box.keyAt(groupIndex) as int;
     context.router.push(TasksWidgetRouter(updateCubit: updateCubit, groupKey: groupKey, tasksUpdateCubit: tasksUpdateCubit, index: groupIndex));
   }

}