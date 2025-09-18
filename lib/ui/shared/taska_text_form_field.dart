import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskaTextFormField extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  TaskaTextFormField({Key? key, required this.labelText, this.controller, this.validator, this.obscureText = false}) : super(key: key);
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
        labelStyle: TextStyle(color: Color(0xFF838993)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Color(0xFFE7EFFD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Color(0xFF665EE2)),
        ),
      ),
    );
  }
}
