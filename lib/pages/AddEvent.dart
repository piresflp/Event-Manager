import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  var _selectedDate; // Valor aparente no DateTime
  var _selectedTime; // Valor aparente no Time
  String dropdownValue = 'Local'; // Valor aparente no DropButton
  TextEditingController txtEvent = TextEditingController();
  TextEditingController txtDate = TextEditingController();
  TextEditingController txtTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: txtEvent,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nome do evento",
                      labelStyle: TextStyle(color: Colors.black),
                      fillColor: Colors.black,
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Data do evento",
                      labelStyle: TextStyle(color: Colors.black),
                      fillColor: Colors.black,
                    ),
                    controller: txtDate,
                    onTap: () {
                      _selectDate(context);
                    },
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Horario do evento",
                      labelStyle: TextStyle(color: Colors.black),
                      fillColor: Colors.black,
                    ),
                    controller: txtTime,
                    onTap: () {
                      _selectTime(context);
                    },
                  ),
                  DropdownButton(
                    value: dropdownValue,
                    icon: const Icon(Icons.place),
                    iconSize: 24,
                    isExpanded: true,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Local', 'One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tight(Size(double.infinity, 55)),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Convidados",
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  _selectTime(BuildContext context) async {
    TimeOfDay? newSelectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (newSelectedTime != null) {
      _selectedTime = newSelectedTime;
      DateTime now = DateTime.now();
      DateTime auxiliar = DateTime(now.year, now.month, now.day,
          newSelectedTime.hour, newSelectedTime.minute);
      txtTime
        ..text = DateFormat("HH:mm").format(auxiliar)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: txtDate.text.length, affinity: TextAffinity.upstream));
    }
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 720)));

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      txtDate
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: txtDate.text.length, affinity: TextAffinity.upstream));
    }
  }
}
