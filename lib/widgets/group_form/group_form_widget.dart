
import 'package:flutter/material.dart';

import '../../presentation/cubit/cubit.dart';
import '../../presentation/cubit/makeGroupsListCubit.dart';

class GroupFromWidget extends StatelessWidget{
   GroupFromWidget({required this.updateCubit, required this.makeGroupsListCubit});
 final UpdateCubit updateCubit;
   final MakeGroupsListCubit makeGroupsListCubit;


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая Группа'),
    ),
        body: Center(
            child: Container(
              child:  Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 16),
                child:  _GroupNameWidget(updateCubit: updateCubit, makeGroupsListCubit: makeGroupsListCubit),
              ),
            ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          updateCubit.saveGroup(context, makeGroupsListCubit, updateCubit);
        },
        child: Icon(Icons.done),
      ),
    );
  }

}


class _GroupNameWidget extends StatelessWidget{
   _GroupNameWidget({required this.updateCubit, required this.makeGroupsListCubit});
   final UpdateCubit updateCubit;
   final MakeGroupsListCubit makeGroupsListCubit;


   @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        TextField(
          autofocus: true,
          decoration:  const InputDecoration(
            border:  OutlineInputBorder(),
            hintText: 'Имя группы',
          ),
          onEditingComplete: (){
            updateCubit.saveGroup(context, makeGroupsListCubit,updateCubit );
          },
          onChanged: (value){
            updateCubit.groupName = value;
          },
        ),
      ],
    );
  }
}