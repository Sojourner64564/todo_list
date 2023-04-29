import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/presentation/cubit/cubit.dart';
import 'package:todo_list/presentation/cubit/tasksUpdateCubit.dart';

import '../../domain/entity/group.dart';
import '../../domain/entity/task.dart';
import '../../providers/routes/routes.gr.dart';

class MakeGroupsListCubit extends Cubit<List<Group>>{
  MakeGroupsListCubit() : super([]);
  var groups = <Group>[];
 // var index = 0;



  void makeList(UpdateCubit updateCubit) async{
    if(!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    groups = box.values.toList(); //:TODO------------------
    updateCubit.initFirstState();


    //emit(box.values.toList());
  }



  void renameGroup(int index , String textFromCon, MakeGroupsListCubit makeGroupsListCubit, UpdateCubit updateCubit) async{
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final groupBox = await Hive.openBox<Group>('groups_box');
    final taskBox = await Hive.openBox<Task>('tasks_box');

    final group = groupBox.getAt(index);
    group?.name = textFromCon;
    group?.save();
    makeGroupsListCubit.makeList(updateCubit); // раньше не было


     //emit(groupBox.values.toList());
  }


}