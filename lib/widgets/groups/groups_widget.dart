import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:auto_route/auto_route.dart';
import 'package:todo_list/domain/entity/group.dart';

import '../../presentation/cubit/cubit.dart';
import '../../presentation/cubit/makeGroupsListCubit.dart';
import '../../presentation/cubit/tasksUpdateCubit.dart';
import '../../providers/routes/routes.gr.dart';

class GroupsWidget extends StatelessWidget {
  final UpdateCubit updateCubit = UpdateCubit();
  final TasksUpdateCubit tasksUpdateCubit = TasksUpdateCubit();
  final MakeGroupsListCubit makeGroupsListCubit = MakeGroupsListCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Группы заметок'),
      ),
      body: SafeArea(
          child: _GroupListWidget(
        updateCubit: updateCubit,
        tasksUpdateCubit: tasksUpdateCubit,
        makeGroupsListCubit: makeGroupsListCubit,
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(GroupFormWidgetRouter(
              updateCubit: updateCubit,
              makeGroupsListCubit: makeGroupsListCubit));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _GroupListWidget extends StatefulWidget {
  _GroupListWidget(
      {required this.updateCubit,
      required this.tasksUpdateCubit,
      required this.makeGroupsListCubit});
  final UpdateCubit updateCubit;
  final TasksUpdateCubit tasksUpdateCubit;
  final MakeGroupsListCubit makeGroupsListCubit;

  @override
  State<_GroupListWidget> createState() => _GroupListWidgetState();
}

class _GroupListWidgetState extends State<_GroupListWidget> {
  void initFirstState() {
    widget.updateCubit.initFirstState();
  }

  @override
  void initState() {
    initFirstState();
    widget.makeGroupsListCubit.makeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateCubit, List>(
        bloc: widget.updateCubit,
        builder: (context, state) {
          return ListView.separated(
            itemCount: state.length,
            itemBuilder: (BuildContext context, int index) {
              return _GroupListRowWidget(
                index: index,
                updateCubit: widget.updateCubit,
                tasksUpdateCubit: widget.tasksUpdateCubit,
                makeGroupsListCubit: widget.makeGroupsListCubit,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 3,
                color: Colors.black54,
                indent: 15,
              );
            },
          );
        });
  }
}

class _GroupListRowWidget extends StatefulWidget {
  _GroupListRowWidget(
      {required this.index,
      required this.updateCubit,
      required this.tasksUpdateCubit,
      required this.makeGroupsListCubit});
  final int index;
  final UpdateCubit updateCubit;
  final TasksUpdateCubit tasksUpdateCubit;
  final MakeGroupsListCubit makeGroupsListCubit;

  @override
  State<_GroupListRowWidget> createState() => _GroupListRowWidgetState();
}

class _GroupListRowWidgetState extends State<_GroupListRowWidget> {
  bool isReadOnly = false;
  final TextEditingController controller = TextEditingController();
  final grey = Colors.grey;
  final white = Colors.white;
  var colorOfText = Colors.white;


  void changeBoolean() {
    setState(() {
      isReadOnly = !isReadOnly;
    });
  }

  void updateNames() {
    controller.text = widget.makeGroupsListCubit.groups[widget.index].name;
  }

  @override
  void initState() {
    updateNames();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: 'Удалить',
          color: Colors.redAccent,
          icon: Icons.delete,
          onTap: () {
            widget.updateCubit.deleteGroup(widget.index, widget.makeGroupsListCubit, widget.updateCubit);
          },
        ),
      ],
      child: BlocBuilder<UpdateCubit, List>(
          bloc: widget.updateCubit,
          builder: (context, state) {
            return ListTile(
              leading: Text('#${widget.index}'),
              title: BlocConsumer<MakeGroupsListCubit, List>(
                    bloc: widget.makeGroupsListCubit,
                    listener: (context, state){
                      if(state != state){updateNames();}
                      if(state == state){updateNames();}
                    },
                    builder: (context, state){
                      return  TextField(
                        enabled: isReadOnly,
                        decoration: const InputDecoration(border: InputBorder.none),
                        controller: controller,
                        onEditingComplete: () {
                          widget.makeGroupsListCubit.renameGroup(
                              widget.index,
                              controller.text,
                              widget.makeGroupsListCubit,);
                          changeBoolean();
                          colorOfText = white;
                        },
                      );
                    },
                  ),
              trailing: SizedBox(
                width: 102,
                child: Row(
                  children: [
                     Text(
                      'Редактирование',
                      style: TextStyle(
                        fontSize: 9,
                        color: colorOfText,
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
              onTap: () {
                widget.updateCubit.showTasksWidget(
                    context,
                    widget.index,
                    widget.updateCubit,
                    widget.tasksUpdateCubit); //TODO: voennoe prestuplenie
              },
              onLongPress: () {
                changeBoolean();
                colorOfText = grey;
              },
            );
          }),
    );
  }
}
