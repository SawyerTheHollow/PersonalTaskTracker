import 'package:first_flutter_project/ui/shared/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskaTextFormField extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  TaskaTextFormField({
    Key? key,
    required this.labelText,
    this.controller,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);
  @override
  _TaskaTextFormFieldState createState() => _TaskaTextFormFieldState();
}

class _TaskaTextFormFieldState extends State<TaskaTextFormField> {
  @override
  Widget build(BuildContext) {
    return TextFormField(
      obscureText: widget.obscureText,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(color: taskaTextGray),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: taskaBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: taskaPurplish),
        ),
      ),
    );
  }
}
