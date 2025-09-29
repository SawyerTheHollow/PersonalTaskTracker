import 'package:first_flutter_project/models/task.dart';
import 'package:first_flutter_project/ui/shared/palette.dart';
import 'package:first_flutter_project/ui/shared/taska_dismissible.dart';
import 'package:flutter/material.dart' hide DismissDirection;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../injection/service_locator.dart';

class TaskaTaskSliverList extends StatefulWidget {
  final List<Task> tasks;
  final bool showCompleted;
  TaskaTaskSliverList({required this.tasks, this.showCompleted = false});

  @override
  _TaskaTaskSliverListState createState() => _TaskaTaskSliverListState();
}

class _TaskaTaskSliverListState extends State<TaskaTaskSliverList> {
  var taskBox = getIt<Box>();

  @override
  Widget build(BuildContext) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: widget.tasks.length, (
        context,
        index,
      ) {
        final task = widget.tasks[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: TaskaDismissible(
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.startToEnd){
                  setState(() {
                    taskBox.put(task.hiveIndex, {
                      'title': taskBox.get(task.hiveIndex)['title'],
                      'text': taskBox.get(task.hiveIndex)['text'],
                      'tag': taskBox.get(task.hiveIndex)['tag'],
                      'date': taskBox.get(task.hiveIndex)['date'],
                      'deadlineDate': taskBox.get(task.hiveIndex)['deadlineDate'],
                      'deadlineTime': taskBox.get(task.hiveIndex)['deadlineTime'],
                      'priority': taskBox.get(task.hiveIndex)['priority'],
                      'isDone': true});

                  });
                }
                return false;
             },
              background: Container(padding: EdgeInsetsGeometry.all(30), alignment:Alignment.centerLeft, color: taskaGreen, child: Icon(Icons.check, color: taskaBackground,),),
              secondaryBackground: Container(padding: EdgeInsetsGeometry.all(30), alignment:Alignment.centerRight, color: taskaRed, child: Icon(Icons.delete, color: taskaBackground,),),
              key: ValueKey(task.hiveIndex),
              onDismissed: (direction) {
                setState(() {
                  taskBox.delete(task.hiveIndex);
                  widget.tasks.removeAt(index);
                });
              },
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: taskaBackground, border: Border.all(color: taskaBorder)),
                height: 80,
                child: ListTile(
                  //TODO Добавить чек-марки
                  leading: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ), //Чек-марки
                  title: Text(
                    task.title,
                    style: TextStyle(color: taskaTextDark, fontSize: 17),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.local_offer_outlined,
                            size: 15,
                            color: taskaPurplish,
                          ),
                        ),
                        TextSpan(text: " "),
                        TextSpan(
                          text: task.tag,
                          style: TextStyle(fontSize: 15, color: taskaTextGray),
                        ),
                        TextSpan(
                          text:
                              "  " +
                              DateFormat("d MMMM hh:mm").format(task.date),
                          style: TextStyle(fontSize: 15, color: taskaRed),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    //TODO Выделение чек-марка
                  },
                  trailing: Icon(Icons.info_outline, color: Color(0xffafd77e)),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class TaskaHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  TaskaHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    //return SizedBox.expand(child: child);
    return Container(color: taskaBackground, child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
