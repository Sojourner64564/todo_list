import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/presentation/cubit/makeGroupsListCubit.dart';
import 'package:todo_list/presentation/cubit/tasksUpdateCubit.dart';

import '../../domain/entity/group.dart';
import '../../domain/entity/task.dart';
import '../../providers/routes/routes.gr.dart';

class UpdateCubit extends Cubit<List<Group>>{
  UpdateCubit() : super([]);
  var groupName = '';
  var tasks = <Task>[];


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


  void saveGroup(BuildContext context, MakeGroupsListCubit makeGroupsListCubit) async{
      if(groupName.isEmpty) return;
      if(!Hive.isAdapterRegistered(1)){
        Hive.registerAdapter(GroupAdapter());
      }
      final box = await Hive.openBox<Group>('groups_box');
      final group = Group(name: groupName);
      await box.add(group);
      emit(box.values.toList());
      makeGroupsListCubit.makeList(); // паньше не было
      navigateBack(context);
  }

  void deleteGroup(int index) async{
    if(!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    await box.deleteAt(index);
    emit(box.values.toList());
  }

  void renameGroup(int index) async{
    if(!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
  //  await box.getAt(index).name
    emit(box.values.toList());
  }



   void showTasksWidget(BuildContext context, int groupIndex, UpdateCubit updateCubit, TasksUpdateCubit tasksUpdateCubit) async{
    final box = await Hive.openBox<Group>('groups_box');
    final groupKey = box.keyAt(groupIndex) as int;
//    final group = box.get(groupKey);

     context.router.push(TasksWidgetRouter(updateCubit: updateCubit, groupKey: groupKey, tasksUpdateCubit: tasksUpdateCubit, index: groupIndex));

   }

}