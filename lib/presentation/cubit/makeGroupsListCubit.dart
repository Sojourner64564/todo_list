import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/presentation/cubit/tasksUpdateCubit.dart';

import '../../domain/entity/group.dart';
import '../../domain/entity/task.dart';
import '../../providers/routes/routes.gr.dart';

class MakeGroupsListCubit extends Cubit<List<Group>>{
  MakeGroupsListCubit() : super([]);
  var groups = <Group>[];
 // var index = 0;



  void makeList() async{
    if(!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    groups = box.values.toList();
    print('object');
    //emit(box.values.toList());
  }

}