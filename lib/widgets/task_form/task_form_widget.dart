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
      backgroundColor: const Color.fromRGBO(40, 132, 126, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(105, 137, 199, 1),
        title: const Text('Новая заметка'),
      ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,

            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
          ),
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(57, 74, 107, 1),
        onPressed: (){
          tasksUpdateCubit.saveTask(context, makeGroupsListCubit, updateCubit);
        },
        child: const Icon(Icons.done),
      ),
    );
  }

}