import 'package:flutter/material.dart';
import 'package:flutter_application_sample_1/helper/locator.dart';
import 'package:flutter_application_sample_1/helper/navigator_service.dart';
import 'package:flutter_application_sample_1/model/create_user.dart';
import 'package:intl/intl.dart';

class MyListDialogPage extends StatefulWidget {
  final CreateUserModel model;
  const MyListDialogPage(this.model);

  @override
  _MyDialogPageState createState() => _MyDialogPageState();
}

class _MyDialogPageState extends State<MyListDialogPage> {
  CreateUserModel model;

  TextEditingController nameCo;
  TextEditingController dateCo;
  DateTime initialDate = DateTime.now();
  DateFormat formatter = DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    model = widget.model;
    nameCo = new TextEditingController();
    dateCo = new TextEditingController();

    nameCo.value = nameCo.value.copyWith(text: model.name);

    initialDate = model.birthDate;
    String dateStr = formatter.format(model.birthDate);
    dateCo.value = nameCo.value.copyWith(text: dateStr);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            children: [
              Text(
                'Update Data',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              TextFormField(
                onChanged: (value) {
                  model.name = value;
                },
                controller: nameCo,
                style: TextStyle(color: Colors.black, fontSize: 12),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  value: model.job,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  hint: Text(
                    'Job',
                    style: TextStyle(color: Colors.black),
                  ),
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                      child: Text('Job 1'),
                      value: 'Job 1',
                    ),
                    DropdownMenuItem(
                      child: Text('Job 2'),
                      value: 'Job 2',
                    ),
                    DropdownMenuItem(
                      child: Text('Job 3'),
                      value: 'Job 3',
                    ),
                  ],
                  onChanged: (value) {
                    model.job = value;
                  },
                  decoration: InputDecoration(
                    // isDense: true,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle:
                        TextStyle(fontSize: 16, color: Colors.grey[200]),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Date',
                  labelStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                //
                readOnly: true,
                controller: dateCo,
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: DateTime(1800),
                    lastDate: DateTime.now(),
                  ).then((date) {
                    if (date != null) {
                      dateCo.text = formatter.format(date);
                      initialDate = date;
                      model.birthDate = date;
                    }
                  });
                },
              ),
              SizedBox(
                height: 24,
              ),
              FlatButton(
                child: Text(
                  'Update Data',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  locator<NavigatorService>().goBack(value: model);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
