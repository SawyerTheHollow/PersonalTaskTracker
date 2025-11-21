import 'package:flutter/material.dart';
import 'package:stripes_mobile_app/shared/consts/theme/colors.dart';

class PrimaryToggleButtons extends StatefulWidget {
  final int selectedValue;
  final Function(int) onValueChanged;

  ///Если не указать высоту и/или ширину, элементы будут пытаться растянуться на всё доступное им пространство по высоте или ширине соответственно.
  ///Особое внимание уделить высоте. При выбранной горизонтальной прокрутке в не ограниченной по высоте области, виджет упадёт
  final double? height;
  final double? width;

  final BorderRadiusGeometry? borderRadius;
  final double startPadding;
  final double spacing;
  final List<Widget> widgetList;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Axis scrollDirection;
  final Widget? actionWidget;

  ///Начальное значение индеска первой кнопки. Нужно использовать, если на экране есть несколько PrimaryToggleButtons и они используются для
  ///выбора чего-то одного из всех этих отдельных PrimaryToggleButtons,
  ///чтобы предотвратить пересечение индексов.
  final int startWithIndex;

  const PrimaryToggleButtons({super.key,
    required this.selectedValue,
    required this.onValueChanged,
    this.height,
    this.width,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.startPadding = 0,
    this.spacing = 10,
    required this.widgetList,
    this.selectedColor = AppColors.blue900,
    this.unselectedColor = AppColors.shade100,
    this.scrollDirection = Axis.horizontal,
    this.actionWidget,
    this.startWithIndex = 0
  });

  @override
  PrimaryToggleButtonsState createState() => PrimaryToggleButtonsState();
}

class PrimaryToggleButtonsState extends State<PrimaryToggleButtons> {
  final ValueNotifier<int> _currentValue = ValueNotifier(-1);

  @override
  void initState() {
    if (_currentValue.value == -1) {
      _currentValue.value = widget.selectedValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: SizedBox(
        height: widget.height,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: widget.scrollDirection,
          itemCount: widget.actionWidget == null ? widget.widgetList.length : widget.widgetList.length + 1,
          itemBuilder: (context, index) {
            if(widget.actionWidget != null){
              return index < widget.widgetList.length ? _statefulButton(index) : widget.actionWidget;
            }
            return _statefulButton(index);
          },
        ),
      ),
    );
  }

  Widget _statefulButton(int index) {
    return ValueListenableBuilder(
      valueListenable: _currentValue,
      builder: (context, value, child) {
        return Padding(
          padding:
              //при горизонтальной прокрутке
          widget.scrollDirection == Axis.horizontal ? EdgeInsets.only(
            left: index == 0 ? widget.startPadding : widget.spacing,
          ) :
              //при вертикальной прокрутке
          EdgeInsets.only(
            top: index == 0 ? widget.startPadding : widget.spacing,
          ),
          child: GestureDetector(
            onTap: () {
              _currentValue.value = index + widget.startWithIndex;
              widget.onValueChanged(_currentValue.value);
              //todo убрать это, сейчас удобно для дебага
              print('текущее выбранное значение: ${_currentValue.value}');
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation){
                return FadeTransition(opacity: animation,
                child: child);
              },
              child: Container(
                key: ValueKey(value == index + widget.startWithIndex),
                alignment: Alignment.center,
                height: widget.height,
                width: widget.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:
                      value == index + widget.startWithIndex
                          ? widget.selectedColor
                          : widget.unselectedColor,
                  borderRadius: widget.borderRadius,
                ),
                child: widget.widgetList[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
