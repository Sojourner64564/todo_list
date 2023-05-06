import 'package:flutter/material.dart';
import 'package:todo_list/presentation/cubit/makeGroupsListCubit.dart';
import '../../presentation/cubit/cubit.dart';
import '../../presentation/cubit/tasksUpdateCubit.dart';


class TaskFormWidget extends StatelessWidget{
  const TaskFormWidget({required this.updateCubit, required this.tasksUpdateCubit, required this.makeGroupsListCubit});
  final UpdateCubit updateCubit;
  final TasksUpdateCubit tasksUpdateCubit;
  final MakeGroupsListCubit makeGroupsListCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая заметка'),
      ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            autofocus: true,
            expands: true,
            maxLines: null,
            minLines: null,
            decoration:  const InputDecoration(
              border:  InputBorder.none,
              hintText: 'Ваша заметка',
            ),
            onChanged: (value){
              tasksUpdateCubit.taskText = value;
            },
            onEditingComplete: (){
              tasksUpdateCubit.saveTask(context, makeGroupsListCubit, updateCubit);
            },
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          tasksUpdateCubit.saveTask(context, makeGroupsListCubit, updateCubit);
        },
        child: Text('bruh'),
      ),
    );
  }

}