import 'package:first_flutter_project/models/task.dart';
import 'package:first_flutter_project/ui/shared/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../injection/service_locator.dart';

class TaskaTaskList extends StatefulWidget {
  final List<Task> tasks;
  final bool showCompleted;
  final VoidCallback? onUpdate;

  TaskaTaskList({
    required this.tasks,
    this.showCompleted = false,
    this.onUpdate
});

  @override
  _TaskaTaskListState createState() => _TaskaTaskListState();
}

class _TaskaTaskListState extends State<TaskaTaskList> {
  final taskBox = getIt<Box>();

  @override
  Widget build (BuildContext){
    if (widget.tasks.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text(
            'Событий нет',
            style: TextStyle(color: taskaTextGray),
          ),
        ),
      );
    }

    return SizedBox(
      child: ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
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
                          child: SvgPicture.asset("assets/icons/check.svg", width: 30, height: 30),
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
                          child: SvgPicture.asset("assets/icons/delete-3-svgrepo-com 1.svg", width: 30, height: 30),
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
                            ],
                          ),
                        ),
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
        },
      ),
    );
  }
}