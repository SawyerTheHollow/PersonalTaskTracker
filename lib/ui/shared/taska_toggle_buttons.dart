import 'package:first_flutter_project/ui/shared/palette.dart';
import 'package:flutter/material.dart';

class TaskaToggleButtons extends StatefulWidget {
  final String selectedValue;
  final Function(String) onValueChanged;
  final List<String> buttons;
  final Size minimumSize;
  final double spacing;
  final bool inactiveBorder;

  TaskaToggleButtons({
    required this.selectedValue,
    required this.onValueChanged,
    required this.buttons,
    this.minimumSize = const Size(50, 30),
    this.spacing = 10,
    this.inactiveBorder = false
  });
  @override
  _TaskaToggleButtonsState createState() => _TaskaToggleButtonsState();
}

class _TaskaToggleButtonsState extends State<TaskaToggleButtons> {
  late String _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = '';
  }

  @override
  Widget build(BuildContext context) {
    if (_currentValue == '') {
      _currentValue = widget.selectedValue;
    }

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(widget.buttons.length, (index) {
            return _statefulButton(widget.buttons[index], index);
          }),
        ),
      ),
    );
  }

  Widget _statefulButton(String value, int index) {
    bool isSelected = widget.selectedValue == value;

    return Container(
      padding: EdgeInsets.only(left: index == 0 ? 0 : widget.spacing),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: widget.minimumSize,
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.transparent,
          side: widget.inactiveBorder == false ? BorderSide(color: isSelected ? taskaPurplish : taskaBorder) : BorderSide(color: isSelected ? taskaPurplish : Colors.transparent),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        onPressed: () {
          setState(() {
            _currentValue = widget.buttons[index];
            widget.onValueChanged(_currentValue);
          });
          print(_currentValue);
        },
        child: Text(
          widget.buttons[index],
          style: TextStyle(
            color: isSelected ? taskaTextDark : taskaTextGray,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
