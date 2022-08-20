import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/custom_keyboard.dart';
import '../database/event_database.dart';
import '../model/event.dart';

class AddNewEvent extends StatefulWidget {
  const AddNewEvent({Key? key, this.event}) : super(key: key);

  final Event? event;
  @override
  State<AddNewEvent> createState() => _AddNewEventState();
}

class _AddNewEventState extends State<AddNewEvent> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final desController = TextEditingController();
  final amountController = TextEditingController();

  DateFormat dateFormat = DateFormat("dd MMM, yyy");
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  List<String> types = ["Expense", "Income"];
  String selectedType = "Expense";

  @override
  void initState() {
    super.initState();
    selectedType = widget.event == null ? 'Expense' : widget.event!.type;
    selectedDate = widget.event == null ? DateTime.now() : widget.event!.date;
    selectedTime = TimeOfDay.fromDateTime(
        widget.event == null ? DateTime.now() : widget.event!.date);
    amountController.addListener(() {});
    amountController.text = widget.event == null ? '' : widget.event!.amount;
    titleController.text = widget.event == null ? '' : widget.event!.title;
    desController.text = widget.event == null ? '' : widget.event!.des;
  }

  @override
  void dispose() {
    titleController.dispose();
    desController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTitleField(context),
                const SizedBox(
                  height: 10,
                ),
                buildDescriptionField(context),
                const SizedBox(
                  height: 10,
                ),
                buildDatePicker(context),
                const SizedBox(
                  height: 10,
                ),
                buildTimePicker(context),
                const SizedBox(
                  height: 10,
                ),
                buildExpensesDropdown(context),
                const SizedBox(
                  height: 12,
                ),
                buildAmountField(context),
                const SizedBox(
                  height: 12,
                ),
                CustomKeyboard(
                  onTextInput: (myText) {
                    _insertText(myText);
                  },
                  onBackspace: () {
                    _backspace();
                  },
                ),
                // buildKeypad(context),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            selectedDate = selectedDate.subtract(Duration(
                hours: selectedDate.hour,
                minutes: selectedDate.minute,
                seconds: selectedDate.second));
            selectedDate = selectedDate.add(Duration(
                hours: selectedTime.hour, minutes: selectedTime.minute));
            if (widget.event == null) {
              Event event = Event(
                  title: titleController.text,
                  des: desController.text,
                  date: selectedDate,
                  type: selectedType,
                  amount: amountController.text);
              event = await EventDatabase.instance.insert(event);
            } else {
              Event event = Event(
                  id: widget.event!.id,
                  title: titleController.text,
                  des: desController.text,
                  date: selectedDate,
                  type: selectedType,
                  amount: amountController.text);
              await EventDatabase.instance.update(event);
            }
            Navigator.pop(context);
          }
        },
        tooltip: "Save Event",
        backgroundColor: Colors.blue,
        child: const Icon(Icons.done),
      ),
    );
  }

  Row buildDatePicker(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: IconButton(
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2050),
                    builder: (context, child) {
                      return Theme(
                          data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                  primary: Colors.grey,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.black87),
                              textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                      primary: Colors.black87))),
                          child: child!);
                    });
                if (pickedDate != null && pickedDate != selectedDate) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              icon: const Icon(Icons.calendar_month_outlined),
              color: Theme.of(context).primaryColorDark.withOpacity(0.8),
            )),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Theme.of(context).primaryColorLight,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 13, left: 10),
              child: Text(
                dateFormat.format(selectedDate),
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container buildTitleField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).primaryColorLight,
      ),
      child: TextFormField(
        controller: titleController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          } else if (value.length > 30) {
            return 'Please enter less than 30 characters';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(fontSize: 14),
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: "Title",
          hintStyle: TextStyle(fontSize: 14),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        cursorColor: Theme.of(context).primaryColorDark,
        readOnly: false,
        showCursor: true,
        maxLines: 1,
      ),
    );
  }

  Container buildDescriptionField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).primaryColorLight,
      ),
      child: TextFormField(
        controller: desController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          } else if (value.length > 100) {
            return 'Please enter less than 100 characters';
          }
          return null;
        },
        style: const TextStyle(fontSize: 14),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: "Description",
          hintStyle: TextStyle(fontSize: 14),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        cursorColor: Theme.of(context).primaryColorDark,
        readOnly: false,
        showCursor: true,
        maxLines: 2,
      ),
    );
  }

  Container buildExpensesDropdown(BuildContext context) {
    return Container(
      // width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).primaryColorLight,
      ),
      child: DropdownButton<String>(
          isExpanded: true,
          value: selectedType,
          items: types
              .map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(
                    e,
                    style: const TextStyle(fontSize: 14),
                  )))
              .toList(),
          onChanged: (item) => setState(() {
                selectedType = item!;
              })),
    );
  }

  Row buildTimePicker(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: IconButton(
              onPressed: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                    builder: (context, child) {
                      return Theme(
                          data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                  primary: Colors.grey,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.black87),
                              textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                      primary: Colors.black87))),
                          child: child!);
                    });
                if (pickedTime != null && pickedTime != selectedTime) {
                  setState(() {
                    selectedTime = pickedTime;
                  });
                }
              },
              icon: const Icon(Icons.access_time),
              color: Theme.of(context).primaryColorDark.withOpacity(0.8),
            )),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Theme.of(context).primaryColorLight,
            ),
            child: Padding(
                padding: const EdgeInsets.only(top: 14, left: 10),
                child: Text(
                  selectedTime.format(context),
                  style: const TextStyle(fontSize: 14),
                )),
          ),
        ),
      ],
    );
  }

  Container buildAmountField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).primaryColorLight,
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some amount';
          }
          return null;
        },
        controller: amountController,
        style: const TextStyle(fontSize: 14),
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: "Amount",
          hintStyle: TextStyle(fontSize: 14),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        cursorColor: Theme.of(context).primaryColorDark,
        readOnly: true,
        showCursor: true,
        maxLines: 1,
      ),
    );
  }

  void _insertText(String myText) {
    final text = amountController.text;
    final textSelection = amountController.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    amountController.text = newText;
    amountController.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  void _backspace() {
    final text = amountController.text;
    final textSelection = amountController.selection;
    final selectionLength = textSelection.end - textSelection.start;

    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      amountController.text = newText;
      amountController.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }

    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }

    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    amountController.text = newText;
    amountController.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }
}
