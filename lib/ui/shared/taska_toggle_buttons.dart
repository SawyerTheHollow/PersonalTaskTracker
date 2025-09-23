import 'package:first_flutter_project/ui/shared/palette.dart';
import 'package:flutter/material.dart';

class TaskaToggleButtons extends StatefulWidget {
  final String selectedPriority;
  final Function(String) onPriorityChanged;

  TaskaToggleButtons({required this.selectedPriority, required this.onPriorityChanged});
  @override
  _TaskaToggleButtonsState createState() => _TaskaToggleButtonsState();
}

class _TaskaToggleButtonsState extends State<TaskaToggleButtons> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _priorityButton("Низкий")),
        SizedBox(width: 17),
        Expanded(child: _priorityButton("Средний")),
        SizedBox(width: 17),
        Expanded(child: _priorityButton("Высокий")),
      ],
    );
  }

  Widget _priorityButton(String value) {
    bool isSelected = widget.selectedPriority == value;

    return SizedBox(height: 45,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            widget.onPriorityChanged(value);
          });
        },
        style: ElevatedButton.styleFrom(
           backgroundColor: Colors.transparent,
          side: BorderSide(
            color: isSelected ? taskaPurplish : taskaBorder,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        child: Text(value, style: TextStyle(
          color: isSelected ? taskaTextDark : taskaTextGray,
          fontSize: 15,
        ),),
      ),
    );
  }
}
