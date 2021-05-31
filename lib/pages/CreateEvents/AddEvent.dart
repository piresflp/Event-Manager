import 'package:Even7/theme/colors.dart';
import 'package:Even7/utils/Api.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Even7/pages/CreateEvents/AddEventInvites.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'Evento.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  var _selectedDate; // Valor aparente no DateTime
  var _selectedTime; // Valor aparente no Time
  String dropdownTipo = 'Tipos'; // Valor aparente no DropButton de tipo
  String dropdownLocal = "Local"; // Valor aparente no DropButton de local
  TextEditingController txtEvent = TextEditingController();
  TextEditingController txtDate = TextEditingController();
  TextEditingController txtTime = TextEditingController();

  String image_picker =
      "https://img.freepik.com/free-vector/pattern-geometric-line-circle-abstract-seamless-blue-line_60284-53.jpg?size=626&ext=jpg";

  String idUser = "";

  Future getId() async {
    String id = await Api.getId();
    setState(() {
      idUser = id;
    });
  }

  @override
  void initState() {
    super.initState();
    getId();
  }

  Widget buildDecoration() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: new NetworkImage(image_picker),
          fit: BoxFit.cover,
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          GestureDetector(
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.image,
                  size: 90,
                  color: Colors.black,
                ),
              ),
              onTap: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['jpg', 'png'],
                );

                if (result != null) {
                  image_picker = result.files.single.path.toString();
                } else {
                  // User canceled the picker
                }
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'Imagem evento',
              style: TextStyle(color: Colors.black, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildDecoration(),
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
                  getLocais(),
                  getTipos(),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tight(Size(double.infinity, 55)),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            Evento new_event = new Evento(
                                nome: txtEvent.text,
                                dia: txtDate.text,
                                hora: txtTime.text,
                                local: dropdownLocal,
                                tipo: dropdownTipo,
                                idOrganizador: idUser,
                                imagem: image_picker);
                            return AddEventInvites(data: new_event);
                          }),
                        );
                      },
                      child: Text(
                        "Continuar",
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  List<DropdownMenuItem<String>> getListLocals(locais) {
    List<DropdownMenuItem<String>> ret = [];
    for (int i = 0; i < locais.length; i++) {
      ret.add(DropdownMenuItem(
          child: Text(locais[i].data()["Descricao"]),
          value: locais[i].data()["Descricao"]));
    }
    return ret;
  }

  Widget getLocais() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Locais").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          var locais = snapshot.data!.docs;
          List<DropdownMenuItem> locals = getListLocals(locais);
          if (!snapshot.hasData) {
            return Container(
              child: Text("No data found"),
            );
          } else {
            return DropdownButton(
              hint: Text(dropdownLocal),
              // value: dropdownLocal,
              icon: const Icon(Icons.place),
              iconSize: 24,
              isExpanded: true,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              onChanged: (dynamic newValue) {
                setState(() {
                  dropdownLocal = newValue.toString();
                });
              },
              items: locals,
            );
          }
        });
  }

  List<DropdownMenuItem<String>> getListTipos(values) {
    List<DropdownMenuItem<String>> ret = [];
    for (int i = 0; i < values.length; i++) {
      ret.add(DropdownMenuItem(
          child: Text(values[i].data()["descricao"]),
          value: values[i].data()["descricao"]));
    }
    return ret;
  }

  Widget getTipos() {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("TiposEventos").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          var tipos = snapshot.data!.docs;
          List<DropdownMenuItem> item_list = getListTipos(tipos);
          if (!snapshot.hasData) {
            return Container(
              child: Text("No data found"),
            );
          } else {
            return DropdownButton(
              hint: Text(dropdownTipo),
              // value: dropdownLocal,
              icon: const Icon(Icons.add_link),
              iconSize: 24,
              isExpanded: true,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              onChanged: (dynamic newValue) {
                setState(() {
                  dropdownTipo = newValue.toString();
                });
              },
              items: item_list,
            );
          }
        });
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
    final f = new DateFormat('dd/MM/yyyy');

    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 720)));

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      txtDate
        ..text = f.format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: txtDate.text.length, affinity: TextAffinity.upstream));
    }
  }
}
