import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../domain/entity/group.dart';
import '../../domain/entity/task.dart';
import '../../presentation/cubit/cubit.dart';
import '../../presentation/cubit/makeGroupsListCubit.dart';
import '../../presentation/cubit/tasksUpdateCubit.dart';
import '../../providers/routes/routes.gr.dart';

class TasksWidget extends StatefulWidget{
  TasksWidget({required this.updateCubit, required this.groupKey, required this.tasksUpdateCubit, required this.index, required this.makeGroupsListCubit});
  final UpdateCubit updateCubit;
  final int groupKey;
  final TasksUpdateCubit tasksUpdateCubit;
  int index = 0;
  final MakeGroupsListCubit makeGroupsListCubit;

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  getIndex(){
    widget.tasksUpdateCubit.groupKey = widget.groupKey;
  }
  @override
  void initState() {
    getIndex();
    setState(() {
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 132, 126, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(105, 137, 199, 1),
        title: BlocBuilder<UpdateCubit, List>(
            bloc: widget.updateCubit,
            builder: (context, state) {
              return Text("Группа '" + (state[widget.index] as Group).name + "':");
            },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(57, 74, 107, 1),
        onPressed: (){
          context.router.push(TaskFormWidgetRouter(updateCubit: widget.updateCubit,
            tasksUpdateCubit: widget.tasksUpdateCubit, makeGroupsListCubit: widget.makeGroupsListCubit,
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: TaskListWidget(tasksUpdateCubit: widget.tasksUpdateCubit, groupKey:widget.groupKey,
        index: widget.index, makeGroupsListCubit: widget.makeGroupsListCubit, updateCubit: widget.updateCubit,),
      );
  }
}




class TaskListWidget extends StatefulWidget{
   TaskListWidget({super.key, required this.tasksUpdateCubit, required this.groupKey, required this.index, required this.makeGroupsListCubit, required this.updateCubit});
  final int groupKey;
  final TasksUpdateCubit tasksUpdateCubit;
  int index = 0;
  final MakeGroupsListCubit makeGroupsListCubit;
  final UpdateCubit updateCubit;

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {

  @override
  void initState() {
    widget.tasksUpdateCubit.initFirstState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<TasksUpdateCubit, List>(
          bloc: widget.tasksUpdateCubit,
          builder: (context, state) {
            if(state.length == 0){
            return const Center(
              heightFactor: 5,
                child: Text('Нет заметок',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
                ),
            );
            }
            else{
              return const Text('');
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: BlocBuilder<TasksUpdateCubit, List>(
              bloc: widget.tasksUpdateCubit,
              builder: (context, state) {
                return ListView.separated(
                  itemCount: state.length,
                  itemBuilder: (BuildContext context, int index){
                    return TaskListRowWidget(index: index, tasksUpdateCubit: widget.tasksUpdateCubit, makeGroupsListCubit: widget.makeGroupsListCubit, updateCubit: widget.updateCubit,);
                  },
                  separatorBuilder: (BuildContext context, int index){
                    return const Divider(height: 3, color: Colors.black87,);
                  },
                );
              },
              ),
        ),
    ],
    );
  }
}


class TaskListRowWidget extends StatelessWidget{
  const TaskListRowWidget({super.key, required this.index, required this.tasksUpdateCubit, required this.makeGroupsListCubit, required this.updateCubit});
  final int index;
  final TasksUpdateCubit tasksUpdateCubit;
  final MakeGroupsListCubit makeGroupsListCubit;
  final UpdateCubit updateCubit;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: 'Удалить',
          color: Colors.redAccent,
          icon: Icons.delete,
          onTap: (){
            tasksUpdateCubit.deleteTask(index, makeGroupsListCubit, updateCubit);
          },
        ),
      ],
      child: BlocBuilder<TasksUpdateCubit, List>(
          bloc: tasksUpdateCubit,
          builder: (context, state) {
            return ListTile(
              tileColor: Colors.white,
              leading: Text('#$index'),
              title:  Text((state[index] as Task).text,),
              trailing: Checkbox(
                activeColor: const Color.fromRGBO(27, 114, 17, 1),
                value: ((state[index] as Task).isDone),
                onChanged: (bool? value) {
                    tasksUpdateCubit.doneToggle(index, value);
                },
              ),
              onTap: (){
                //----------------------------------------
              },
            );
          }
      ),
    );
  }

}

