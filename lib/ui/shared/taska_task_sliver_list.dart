import 'package:first_flutter_project/models/task.dart';
import 'package:first_flutter_project/ui/shared/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../injection/service_locator.dart';

class TaskaTaskSliverList extends StatefulWidget {
  final List<Task> tasks;
  final bool showCompleted;
  final VoidCallback? onUpdate;

  TaskaTaskSliverList({required this.tasks, this.showCompleted = false, this.onUpdate});

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
            child: Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                Positioned.fill(
                  right: 200,
                  child: Container(color: taskaGreen),
                ),
                Positioned.fill(left: 200, child: Container(color: taskaRed)),
                Slidable(
                  startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    extentRatio: 0.2,
                    children: [
                      CustomSlidableAction(
                        foregroundColor: taskaBackground,
                        backgroundColor: taskaGreen,
                        child: Icon(
                          Icons.check,
                          size: 30,
                          color: taskaBackground,
                        ),
                        onPressed: (context) {
                          setState(() {
                            taskBox.put(task.hiveIndex, {
                              'title': taskBox.get(task.hiveIndex)['title'],
                              'text': taskBox.get(task.hiveIndex)['text'],
                              'tag': taskBox.get(task.hiveIndex)['tag'],
                              'date': taskBox.get(task.hiveIndex)['date'],
                              'deadlineDate': taskBox.get(
                                task.hiveIndex,
                              )['deadlineDate'],
                              'deadlineTime': taskBox.get(
                                task.hiveIndex,
                              )['deadlineTime'],
                              'priority': taskBox.get(
                                task.hiveIndex,
                              )['priority'],
                              'isDone': true,
                            });
                            widget.tasks.removeAt(index);
                            widget.onUpdate!();
                          });
                        },
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    extentRatio: 0.2,
                    motion: ScrollMotion(),
                    children: [
                      CustomSlidableAction(
                        foregroundColor: taskaBackground,
                        backgroundColor: taskaRed,
                        child: Icon(
                          Icons.delete,
                          size: 30,
                          color: taskaBackground,
                        ),
                        onPressed: (context) {
                          setState(() {
                            taskBox.delete(task.hiveIndex);
                            widget.tasks.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                  key: ValueKey(task.hiveIndex),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: taskaBackground,
                      border: Border.all(color: taskaBorder),
                    ),
                    height: 80,
                    child: ListTile(
                      leading: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border.all(color: taskaTextDark),
                          borderRadius: BorderRadius.circular(5),
                          color: taskBox.get(task.hiveIndex)['isDone'] == true ? taskaGreen : taskaBackground
                        ),
                        child: taskBox.get(task.hiveIndex)['isDone'] == true ? Icon(Icons.check, size: 15, opticalSize: 10,) : null,
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(color: taskaTextDark, fontSize: 17, decoration: taskBox.get(task.hiveIndex)['isDone'] == true ? TextDecoration.lineThrough : null),
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
                              style: TextStyle(
                                fontSize: 15,
                                color: taskaTextGray,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "  " +
                                  //DateFormat("d MMMM hh:mm").format(task.date),
                                      DateFormat.MMMMd('ru').format(task.date) + " " +
                                      DateFormat("hh:mm").format(task.date),
                              style: TextStyle(fontSize: 15, color: taskaRed),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        //TODO Выделение чек-марка
                      },
                      trailing: Icon(
                        Icons.info_outline,
                        color: Color(0xffafd77e),
                      ),
                    ),
                  ),
                ),
              ],
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
    return Container(color: taskaBackground, child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
