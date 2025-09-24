import 'package:first_flutter_project/ui/shared/palette.dart';
import 'package:flutter/material.dart';

class TaskaElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  final Size minimumSize;
  const TaskaElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fontSize = 20,
    this.fontWeight = FontWeight.normal,
    this.minimumSize = const Size(0, 55),
  }) : super(key: key);

  @override
  Widget build(BuildContext) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shadowColor: taskaPurplish,
        elevation: 20,
        minimumSize: minimumSize,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        backgroundColor: taskaPurplish,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: taskaBackground,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
