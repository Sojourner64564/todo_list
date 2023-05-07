import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:auto_route/auto_route.dart';
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
      backgroundColor: const Color.fromRGBO(40, 132, 126, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(235, 165, 112, 1),
        title: const Text('Группы заметок'),
      ),
      body: SafeArea(
          child: _GroupListWidget(
        updateCubit: updateCubit,
        tasksUpdateCubit: tasksUpdateCubit,
        makeGroupsListCubit: makeGroupsListCubit,
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(161, 113, 77, 1),
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
    widget.updateCubit.initGroupState(); // новое
  }
  void initAmountOfGroup(){
    widget.updateCubit.initAmountOfGroup(widget.makeGroupsListCubit);
  }

  @override
  void initState() {
    initAmountOfGroup();
    initFirstState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateCubit, List>(
        bloc: widget.updateCubit,
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (BuildContext context, int index) {
              return _GroupListRowWidget(
                index: index,
                updateCubit: widget.updateCubit,
                tasksUpdateCubit: widget.tasksUpdateCubit,
                makeGroupsListCubit: widget.makeGroupsListCubit,
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
    controller.text = widget.updateCubit.groups[widget.index].name;
  }

  void initTaskNames(){
    widget.tasksUpdateCubit.initFirstState();
  }

  @override
  void initState() {
    widget.makeGroupsListCubit.fillList();
    updateNames();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Slidable(
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
        child: BlocConsumer<UpdateCubit, List>(
            bloc: widget.updateCubit,
            listener: (context, state){
              updateNames();
              widget.makeGroupsListCubit.initInGroupsState(widget.index);
            },
            builder: (context, state) {
              return ListTile(
                shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                ),
                tileColor: Colors.white,
                leading: Text('#${widget.index}'),
                subtitle: BlocBuilder<MakeGroupsListCubit, List>(
                  bloc: widget.makeGroupsListCubit,
                  /*listener: (context, state){
                    initTaskNames();
                  },*/
                  builder: (context, state){
                    return Text(
                        state[widget.index],
                    maxLines: 2,
                    );
                 },
                ),
                title: TextField(
                          enabled: isReadOnly,
                          decoration: const InputDecoration(border: InputBorder.none),
                          controller: controller,
                          onEditingComplete: () {
                            widget.updateCubit.renameGroup(
                                widget.index,
                                controller.text,
                                widget.makeGroupsListCubit,);
                            changeBoolean();
                            colorOfText = white;
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
                      widget.tasksUpdateCubit,
                      widget.makeGroupsListCubit
                  ); //TODO: voennoe prestuplenie
                },
                onLongPress: () {
                  changeBoolean();
                  colorOfText = grey;
                },
              );
            }),
      ),
    );
  }
}
