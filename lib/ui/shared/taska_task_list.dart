import 'package:first_flutter_project/models/task.dart';
import 'package:first_flutter_project/ui/shared/palette.dart';
import 'package:flutter/material.dart';

class TaskaTaskList extends StatefulWidget {
  final List<Task> tasks;
  TaskaTaskList({
    required this.tasks
});


  @override
  _TaskaTaskListState createState() => _TaskaTaskListState();
}

class _TaskaTaskListState extends State<TaskaTaskList> {
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
      height: 450,
      child: ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          final task = widget.tasks[index];
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: taskaBorder),
            ),
            color: taskaBackground,
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Container(
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
                    ],
                  ),
                ),
                onTap: () {
                  //TODO Выделение чек-марка
                },
                trailing: Icon(Icons.info_outline, color: Color(0xffafd77e)),
              ),
            ),
          );
        },
      ),
    );
  }
}