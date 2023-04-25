

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/domain/entity/group.dart';

class GroupFormWidgetModel {
var groupName = '';
  void saveGroup(BuildContext context) async{
      if(groupName.isEmpty) return;
      if(!Hive.isAdapterRegistered(1)){
        Hive.registerAdapter(GroupAdapter());
      }
      final box = await Hive.openBox<Group>('groups_box');
      final group = Group(name: groupName);
      await box.add(group);
      (){
        context.router.pop();
      };
  }
}