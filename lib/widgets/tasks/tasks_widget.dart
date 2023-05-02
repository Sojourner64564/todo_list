import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../domain/entity/group.dart';
import '../../domain/entity/task.dart';
import '../../presentation/cubit/cubit.dart';
import '../../presentation/cubit/tasksUpdateCubit.dart';
import '../../providers/routes/routes.gr.dart';

class TasksWidget extends StatefulWidget{
  TasksWidget({required this.updateCubit, required this.groupKey, required this.tasksUpdateCubit, required this.index});
  final UpdateCubit updateCubit;
  final int groupKey;
  final TasksUpdateCubit tasksUpdateCubit;
  int index = 0;

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
      appBar: AppBar(
        title: BlocBuilder<UpdateCubit, List>(
            bloc: widget.updateCubit,
            builder: (context, state) {
              return Text("Группа '" + (state[widget.index] as Group).name + "':");
            },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          context.router.push(TaskFormWidgetRouter(updateCubit: widget.updateCubit, tasksUpdateCubit: widget.tasksUpdateCubit));
        },
        child: Icon(Icons.add),
      ),
      body: TaskListWidget(tasksUpdateCubit: widget.tasksUpdateCubit, groupKey:widget.groupKey, index: widget.index,),
      );
  }
}




class TaskListWidget extends StatefulWidget{
   TaskListWidget({super.key, required this.tasksUpdateCubit, required this.groupKey, required this.index});
  final int groupKey;
  final TasksUpdateCubit tasksUpdateCubit;
  int index = 0;

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
    return BlocBuilder<TasksUpdateCubit, List>(
          bloc: widget.tasksUpdateCubit,
          builder: (context, state) {
            return ListView.separated(
              itemCount: state.length,
              itemBuilder: (BuildContext context, int index){
                return TaskListRowWidget(index: index, tasksUpdateCubit: widget.tasksUpdateCubit);
              },
              separatorBuilder: (BuildContext context, int index){
                return const Divider(height: 3, color: Colors.black87,);
              },
            );
          },
          );
  }
}


class TaskListRowWidget extends StatelessWidget{
  const TaskListRowWidget({super.key, required this.index, required this.tasksUpdateCubit});
  final int index;
  final TasksUpdateCubit tasksUpdateCubit;

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
            tasksUpdateCubit.deleteTask(index);
          },
        ),
      ],
      child: BlocBuilder<TasksUpdateCubit, List>(
          bloc: tasksUpdateCubit,
          builder: (context, state) {
            return ListTile(
              leading: Text('#$index'),
              title:  Text((state[index] as Task).text),
              trailing: Checkbox(
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

