
import 'package:hive/hive.dart';
import 'package:todo_list/domain/entity/task.dart';
part 'group.g.dart';

@HiveType(typeId: 1)
class Group extends HiveObject{
  Group({required this.name});

  @HiveField(0)
  String name;

  @HiveField(1)
  HiveList<Task>? tasks;

  void addTask(Box<Task> box, Task task){
    tasks ??= HiveList(box);
    tasks?.add(task);
    save();
  }


}
