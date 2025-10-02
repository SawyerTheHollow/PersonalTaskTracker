import 'package:first_flutter_project/ui/shared/palette.dart';
import 'package:flutter/material.dart';

class TaskaTextFormField extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final double height;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  TaskaTextFormField({
    Key? key,
    required this.labelText,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.height = 20,
    this.prefixIcon,
    this.onChanged
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
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        prefixIconConstraints: BoxConstraints(minWidth: 25, minHeight: 25),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: widget.prefixIcon,
        ),
        contentPadding: EdgeInsets.all(widget.height),
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
