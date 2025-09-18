import 'package:flutter/cupertino.dart';

class TaskaTitleText extends StatelessWidget {
  final String topText;
  final String bottomText;
  final double topFontSize;
  final double bottomFontSize;
  final TextAlign textAlign;
  final FontWeight topFontWeight;
  final FontWeight bottomFontWeight;
  final double height;
  final double spaceBetween;
  final CrossAxisAlignment columnAlignment;
  TaskaTitleText({
    Key? key,
    required this.topText,
    required this.bottomText,
    this.topFontSize = 28,
    this.bottomFontSize = 15,
    this.topFontWeight = FontWeight.bold,
    this.bottomFontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.height = 1.4,
    this.spaceBetween = 0,
    this.columnAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: columnAlignment,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          topText,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: topFontSize,
            color: Color(0xFF2F394A),
            fontWeight: topFontWeight,
            height: height,
          ),
        ),
        SizedBox(height: spaceBetween),
        Text(
          bottomText,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: bottomFontSize,
            color: Color(0xFFB8B8BA),
            fontWeight: bottomFontWeight,
          ),
        ),
      ],
    );
  }
}
