import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/data_provider/box_manager.dart';
import '../../domain/entity/group.dart';
import '../../domain/entity/task.dart';

class MakeGroupsListCubit extends Cubit<List<String>> {
  MakeGroupsListCubit() : super([]);
  int groupKey = 0;
  //int groupKeyForGroupWidget = 0;
  // int indexForGroups = 0;
  var taskText = '';
  var tasks = <Task>[];
  var newTasks = <Task>[];
  int groups = 0;
//  String? firstTask;
  var firstTasks = <String>[];

  void controlTheList(List<Group> groupsLocal){
    for(int i=0;i<groupsLocal.length;i++){
      firstTasks.add('загрузка...');
    }
  }

  void incrementInList(){
    firstTasks.add('загрузка...');
  }
  void decrementInList(){
    firstTasks.removeLast();
  }

  void getAmountOfGroups(List<Group> groupsLocal) {
    groups = groupsLocal.toList().length;
    controlTheList(groupsLocal);
    // print('$groups ====getAmountOfGroups его сообщение=============================================================');
    for (int i = 0; i < groups; i++) {
      initInGroupsState(i);
    }
  }

  void initInGroupsState(int index) async {
    final groupBox = await BoxManager.instance.openGroupBox();
    final localGroupKey = groupBox.keyAt(index) as int;
    final taskBox = await BoxManager.instance.openTaskBox(localGroupKey);
    newTasks = taskBox.values.toList();
    // print(newTasks.toString() + index.toString() + 'ffffffffffffffffffffffffffffff');
    //print('our index ' + index.toString());
    // print(' - ' + (newTasks.length != 0 ? newTasks[0].text : myString).toString() + index.toString());
    firstTasks[index] = (' - ' + (newTasks.length != 0 ? newTasks[0].text : 'пустая группа').toString());//huesos moment
    emit(firstTasks.toList());
  }

  void fillList() {
    emit(firstTasks.toList());
  }
}
