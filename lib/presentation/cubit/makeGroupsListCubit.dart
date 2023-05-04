import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/presentation/cubit/cubit.dart';
import 'package:todo_list/presentation/cubit/tasksUpdateCubit.dart';

import '../../domain/data_provider/box_manager.dart';
import '../../domain/entity/group.dart';
import '../../domain/entity/task.dart';
import '../../providers/routes/routes.gr.dart';

class MakeGroupsListCubit extends Cubit<List<Group>>{
  MakeGroupsListCubit() : super([]);
  var groups = <Group>[];



  void makeList() async{
    final box = await BoxManager.instance.openGroupBox();
    groups = box.values.toList();
    emit(groups.toList());
  }



  void renameGroup(int index , String textFromCon, MakeGroupsListCubit makeGroupsListCubit) async{
    final groupBox = await BoxManager.instance.openGroupBox();
    //final taskBox = await BoxManager.instance.openTaskBox();

    final group = groupBox.getAt(index);
    group?.name = textFromCon;
    group?.save();
    makeList();
  }


}