import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:auto_route/auto_route.dart';
import 'package:todo_list/domain/entity/group.dart';

import '../../presentation/cubit/cubit.dart';
import '../../presentation/cubit/tasksUpdateCubit.dart';
import '../../providers/routes/routes.gr.dart';

class GroupsWidget extends StatelessWidget{
  final  UpdateCubit updateCubit = UpdateCubit();
  final TasksUpdateCubit tasksUpdateCubit = TasksUpdateCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Группы заметок'),
      ),
      body:  SafeArea(
          child: _GroupListWidget(updateCubit: updateCubit, tasksUpdateCubit:tasksUpdateCubit )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          context.router.push(GroupFormWidgetRouter(updateCubit: updateCubit));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


class _GroupListWidget extends StatefulWidget{
   _GroupListWidget({required this.updateCubit, required this.tasksUpdateCubit});
  final UpdateCubit updateCubit;
  final TasksUpdateCubit tasksUpdateCubit;

  @override
  State<_GroupListWidget> createState() => _GroupListWidgetState();
}

class _GroupListWidgetState extends State<_GroupListWidget> {

  void initFirstState(){
    widget.updateCubit.initFirstState();
  }

  @override
  void initState() {
    initFirstState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateCubit, List>(
        bloc: widget.updateCubit,
        builder: (context, state) {
          return ListView.separated(
            itemCount: state.length,
            itemBuilder: (BuildContext context, int index){
              return  _GroupListRowWidget(index: index, updateCubit: widget.updateCubit, tasksUpdateCubit: widget.tasksUpdateCubit,);
            },
            separatorBuilder: (BuildContext context, int index){
              return const Divider(height: 3);
            },
          );
        }
    );
  }
}


class _GroupListRowWidget extends StatelessWidget{
 const _GroupListRowWidget({required this.index, required this.updateCubit, required this.tasksUpdateCubit});
 final int index;
 final UpdateCubit updateCubit;
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
              updateCubit.deleteGroup(index);
            },
          ),
        ],
        child: BlocBuilder<UpdateCubit, List>(
            bloc: updateCubit,
            builder: (context, state) {
              return ListTile(
                title:  Text((state[index] as Group).name),
                trailing: const Icon(Icons.chevron_right),
                onTap: (){
                  //TODO: ---------------------------------------------------------------------
                  updateCubit.showTasksWidget(context, index, updateCubit, tasksUpdateCubit); //TODO: voennoe prestuplenie
                },
              );
            }
        ),
      );
  }

}