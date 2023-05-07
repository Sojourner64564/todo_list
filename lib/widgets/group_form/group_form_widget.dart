
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
      backgroundColor: const Color.fromRGBO(40, 132, 126, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(235, 165, 112, 1),
        title: const Text('Создать группу'),
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
        backgroundColor: const Color.fromRGBO(161, 113, 77, 1),
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
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          width: 600,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextField(
                autofocus: true,
                decoration:  const InputDecoration(
                  border:  InputBorder.none,
                  hintText: 'Имя группы',
                ),
                onEditingComplete: (){
                  updateCubit.saveGroup(context, makeGroupsListCubit,updateCubit );
                },
                onChanged: (value){
                  updateCubit.groupName = value;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}