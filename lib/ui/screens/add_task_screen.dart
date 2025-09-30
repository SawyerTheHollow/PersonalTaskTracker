import 'package:custom_check_box/custom_check_box.dart';
import 'package:first_flutter_project/ui/shared/palette.dart';
import 'package:first_flutter_project/ui/shared/taska_elevated_button.dart';
import 'package:first_flutter_project/ui/shared/taska_text_form_field.dart';
import 'package:first_flutter_project/ui/shared/taska_toggle_buttons.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../injection/service_locator.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({Key? key});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var taskBox = getIt<Box>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _textController = TextEditingController();
  TextEditingController _tagController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime? _date = null;
  TextEditingController _timeController = TextEditingController();
  TimeOfDay? _time = TimeOfDay.now();
  TextEditingController _deadlineDateController = TextEditingController();
  TextEditingController _deadlineTimeController = TextEditingController();
  String _selectedTag = "Без тега";
  String _selectedValue = "Низкий";
  bool _showDeadlineForms = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Функция для валидации текстового поля
  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Это поле обязательно для заполнения";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final String currentDate = DateFormat('dd.MM.yyyy').format(DateTime.now());
    final String currentTime = DateFormat('hh.mm').format(DateTime.now());
    //_dateController.text = currentDate;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        title: Text("Добавить задачу"),
        backgroundColor: taskaBackground,
      ),
      backgroundColor: taskaBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Наименование задачи",
                  style: TextStyle(color: taskaTextGray, fontSize: 15),
                ),
                SizedBox(height: 15),
                TaskaTextFormField(
                  labelText: "Текст наименования задачи",
                  controller: _titleController,
                  validator: _validator,
                ),
                SizedBox(height: 15),
                Text(
                  "Примечание",
                  style: TextStyle(color: taskaTextGray, fontSize: 15),
                ),
                SizedBox(height: 15),
                TaskaTextFormField(
                  labelText: "Текст примечания",
                  controller: _textController,
                ),
                SizedBox(height: 15),
                Text(
                  "Выбрать тег",
                  style: TextStyle(color: taskaTextGray, fontSize: 15),
                ),
                SizedBox(height: 15),
                DropdownButtonFormField(
                  hint: Text(
                    "Без тега",
                    style: TextStyle(color: taskaTextGray, fontSize: 16),
                  ),
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        "Без тега",
                        style: TextStyle(color: taskaTextDark),
                      ),
                      value: "Без тега",
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "Покупки",
                        style: TextStyle(color: taskaTextDark),
                      ),
                      value: "Покупки",
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "Работа",
                        style: TextStyle(color: taskaTextDark),
                      ),
                      value: "Работа",
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "Семья",
                        style: TextStyle(color: taskaTextDark),
                      ),
                      value: "Семья",
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "Учёба",
                        style: TextStyle(color: taskaTextDark),
                      ),
                      value: "Учёба",
                    ),
                  ],
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: taskaPurplish,
                    size: 40,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _tagController.text = value ?? "";
                      _selectedTag = _tagController.text;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: taskaPurplish),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: taskaBorder),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Дата",
                              style: TextStyle(
                                color: taskaTextGray,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              validator: _validator,
                              style: TextStyle(
                                fontSize: 20,
                                color: taskaTextDark,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20),
                                hint: Text(
                                  currentDate,
                                  style: TextStyle(
                                    color: taskaTextGray,
                                    fontSize: 16,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(color: taskaBorder),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(color: taskaPurplish),
                                ),
                              ),
                              controller: _dateController,
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                _dateController.text = DateFormat(
                                  'dd.MM.yyyy',
                                ).format(picked!);
                                _date = picked;
                                //_date = DateFormat('yyyy-MM-dd').format(picked);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Время",
                              style: TextStyle(
                                color: taskaTextGray,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              style: TextStyle(
                                fontSize: 20,
                                color: taskaTextDark,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20),
                                hint: Text(
                                  currentTime,
                                  style: TextStyle(
                                    color: taskaTextGray,
                                    fontSize: 16,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(color: taskaBorder),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(color: taskaPurplish),
                                ),
                              ),
                              controller: _timeController,
                              onTap: () async {
                                final TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                final hour = picked?.hour.toString().padLeft(
                                  2,
                                  '0',
                                );
                                final minute = picked?.minute
                                    .toString()
                                    .padLeft(2, '0');
                                _timeController.text = '$hour:$minute';

                                _time = picked;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CustomCheckBox(
                        checkedIcon: Icons.check,
                        borderRadius: 12,
                        checkBoxSize: 40,
                        checkedIconColor: taskaTextDark,
                        borderColor: taskaTextDark,
                        shouldShowBorder: true,
                        checkedFillColor: taskaGreen,
                        value: _showDeadlineForms,
                        onChanged: (bool? value) {
                          setState(() {
                            _showDeadlineForms = value ?? false;
                          });
                        },
                      ),
                    ),
                    Text(
                      "Есть срок?",
                      style: TextStyle(color: taskaTextGray, fontSize: 15),
                    ),
                  ],
                ),
                if (_showDeadlineForms) ...[
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Выполнить до",
                                style: TextStyle(
                                  color: taskaTextGray,
                                  fontSize: 15,
                                ),
                              ),
                              TextFormField(
                                style: TextStyle(
                                  fontSize: 20,
                                  color: taskaTextDark,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  hint: Text(
                                    currentTime,
                                    style: TextStyle(
                                      color: taskaTextGray,
                                      fontSize: 16,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide(color: taskaBorder),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide(
                                      color: taskaPurplish,
                                    ),
                                  ),
                                ),
                                controller: _deadlineDateController,
                                onTap: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  _deadlineDateController.text = DateFormat(
                                    'dd.MM.yyyy',
                                  ).format(picked!);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Время",
                                style: TextStyle(
                                  color: taskaTextGray,
                                  fontSize: 15,
                                ),
                              ),
                              TextFormField(
                                style: TextStyle(
                                  fontSize: 20,
                                  color: taskaTextDark,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  hint: Text(
                                    currentTime,
                                    style: TextStyle(
                                      color: taskaTextGray,
                                      fontSize: 16,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide(color: taskaBorder),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide(
                                      color: taskaPurplish,
                                    ),
                                  ),
                                ),
                                controller: _deadlineTimeController,
                                onTap: () async {
                                  final TimeOfDay? picked =
                                      await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                  final hour = picked?.hour.toString().padLeft(
                                    2,
                                    '0',
                                  );
                                  final minute = picked?.minute
                                      .toString()
                                      .padLeft(2, '0');
                                  _deadlineTimeController.text =
                                      '$hour:$minute';
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 15),
                Text(
                  "Приоритет",
                  style: TextStyle(color: taskaTextGray, fontSize: 15),
                ),
                SizedBox(height: 15),
                TaskaToggleButtons(
                  minimumSize: Size(110, 45),
                  spacing: 20,
                  selectedValue: _selectedValue,
                  onValueChanged: (String newValue) {
                    setState(() {
                      _selectedValue = newValue;
                    });
                  },
                  buttons: ["Низкий", "Средний", "Высокий"],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      child: TaskaElevatedButton(
                        text: "Добавить",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final dateAndTimeCombined = DateTime(
                              _date!.year,
                              _date!.month,
                              _date!.day,
                              _time!.hour,
                              _time!.minute,
                            ).toUtc().toIso8601String();
                            taskBox.add({
                              'title': _titleController.text,
                              'text': _textController.text,
                              'tag': _selectedTag,
                              //TODO Уточнить отличия дат ниже \/
                              'date': dateAndTimeCombined,
                              //'date': _dateController.text,
                              //'time': _timeController.text,
                              'deadlineDate': _deadlineDateController.text,
                              'deadlineTime': _deadlineTimeController.text,
                              'priority': _selectedValue,
                              'isDone': false,
                            });
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Заполните поля, выделенные красным',
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    /* ElevatedButton(
                      onPressed: () {
                        for(int key in taskBox.keys ) {
                          //taskBox.delete(key);
                          print(taskBox.get(key));
                        }


                      },
                      child: Text("data"),
                    ),*/
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
