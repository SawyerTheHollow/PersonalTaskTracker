import 'package:first_flutter_project/models/task.dart';
import 'package:first_flutter_project/ui/shared/palette.dart';
import 'package:first_flutter_project/ui/shared/taska_dismissible.dart';
import 'package:flutter/material.dart';
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
              background: Container(color: taskaRed),
              secondaryBackground: Container(color: taskaGreen),
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
