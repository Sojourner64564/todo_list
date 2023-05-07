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

class MakeGroupsListCubit extends Cubit<List<String>>{
  MakeGroupsListCubit() : super([]);
  int groupKey = 0;
  //int groupKeyForGroupWidget = 0;
  // int indexForGroups = 0;
  var taskText='';
  var tasks = <Task>[];
  var newTasks = <Task>[];
  int groups=0;
//  String? firstTask;
  var firstTasks = <String>['загрузка...','загрузка...','загрузка...','загрузка...','загрузка...'];
final emptyList = <Task>[];
String myString = 'huilo';

  void getAmountOfGroups(List<Group> groupsLocal){
    groups = groupsLocal.toList().length;
    print('$groups ====getAmountOfGroups его сообщение=============================================================');
    for(int i=0;i<groups;i++){
      initInGroupsState(i);
    }
  }

  void initInGroupsState(int index) async{
    final groupBox = await BoxManager.instance.openGroupBox();
     final localGroupKey = groupBox.keyAt(index) as int;
      final taskBox = await BoxManager.instance.openTaskBox(localGroupKey);
      newTasks = taskBox.values.toList();
     // print(newTasks.toString() + index.toString() + 'ffffffffffffffffffffffffffffff');
      print('our index ' + index.toString());
print(' - ' + (newTasks[0] != null ? newTasks[0].text : myString).toString() + index.toString());
      firstTasks[index] = (' - ' + (newTasks[0].text.isNotEmpty ? newTasks[0].text: 'empty').toString());
       emit(firstTasks.toList());
  }

  void fillList(){
    emit(firstTasks.toList());
  }


}