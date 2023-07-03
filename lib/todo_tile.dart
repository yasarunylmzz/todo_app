import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskComplete;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? settingsTask;
  ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskComplete,
      required this.onChanged,
      required this.deleteFunction,
      required this.settingsTask});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Slidable(
        endActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: settingsTask,
              icon: Icons.settings,
              backgroundColor: Colors.blueGrey,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(blurRadius: 5, offset: Offset(0, 10))]),
          child: Row(
            children: [
              //checkBox
              Checkbox(
                value: taskComplete,
                onChanged: onChanged,
                activeColor: Colors.black,
                checkColor: Colors.yellow,
              ),
              //task name
              Text(
                taskName,
                style: TextStyle(
                    decoration: taskComplete
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
