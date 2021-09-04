import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_application_sample_1/helper/locator.dart';
import 'package:flutter_application_sample_1/helper/navigator_service.dart';
//import 'package:flutter_application_sample_1/bloc/bloc/bloc/course_bloc.dart';
//import 'package:flutter_application_sample_1/bloc/event/course_event.dart';
//import 'package:flutter_application_sample_1/helper/locator.dart';
//import 'package:flutter_application_sample_1/helper/navigator_service.dart';
import 'package:flutter_application_sample_1/model/course.dart';

//import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

class MyListDialogCoursePage extends StatefulWidget {
  final Course model;
  const MyListDialogCoursePage(this.model);

  @override
  _MyDialogPageState createState() => _MyDialogPageState();
}

class _MyDialogPageState extends State<MyListDialogCoursePage> {
  Course model;

  TextEditingController nameCo;
  TextEditingController dateCo;
  DateTime initialDate = DateTime.now();
  DateFormat formatter = DateFormat('dd-MM-yyyy');

  TextEditingController codeCo;
  TextEditingController descCo;
  TextEditingController creditCo;

  @override
  void initState() {
    super.initState();
    model = widget.model;
    nameCo = new TextEditingController();
    dateCo = new TextEditingController();
    codeCo = new TextEditingController();
    descCo = new TextEditingController();
    creditCo = new TextEditingController();

    nameCo.value = nameCo.value.copyWith(text: model.courseName);
    codeCo.value = codeCo.value.copyWith(text: model.courseCode);
    descCo.value = descCo.value.copyWith(text: model.courseDesc);
    creditCo.value = creditCo.value.copyWith(text: model.credits.toString());

    // nameCo.value = nameCo.value.copyWith(text: model.name);

    // initialDate = model.birthDate;
    // String dateStr = formatter.format(model.birthDate);
    // dateCo.value = nameCo.value.copyWith(text: dateStr);
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
                  model.courseCode = value;
                },
                controller: codeCo,
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
                  labelText: 'Course Code',
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
                  value: model.courseName,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  hint: Text(
                    'SKS',
                    style: TextStyle(color: Colors.black),
                  ),
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                      child: Text('MTK'),
                      value: 'MTK',
                    ),
                    DropdownMenuItem(
                      child: Text('Fisika'),
                      value: 'Fisika',
                    ),
                    DropdownMenuItem(
                      child: Text('Kimia'),
                      value: 'Kimia',
                    ),
                  ],
                  onChanged: (value) {
                    model.courseName = value;
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
                onChanged: (value) {
                  model.courseDesc = value;
                },
                controller: descCo,
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
                  labelText: 'Course Description',
                  labelStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]+'))
                ],
                onChanged: (value) {
                  model.credits = int.parse(value);
                },
                controller: creditCo,
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
                  labelText: 'SKS',
                  labelStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              // TextFormField(
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: Colors.grey[200],
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(4),
              //       borderSide: BorderSide(color: Colors.black),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(4),
              //         borderSide: BorderSide(color: Colors.black)),
              //     labelText: 'Date',
              //     labelStyle: TextStyle(
              //       fontSize: 15,
              //       color: Colors.black,
              //     ),
              //   ),
              //   //
              //   readOnly: true,
              //   controller: dateCo,
              //   onTap: () {
              //     showDatePicker(
              //       context: context,
              //       initialDate: initialDate,
              //       firstDate: DateTime(1800),
              //       lastDate: DateTime.now(),
              //     ).then((date) {
              //       if (date != null) {
              //         dateCo.text = formatter.format(date);
              //         initialDate = date;
              //         model.birthDate = date;
              //       }
              //     });
              //   },
              // ),
              // SizedBox(
              //   height: 24,
              // ),
              FlatButton(
                child: Text(
                  'Update Data',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  //BlocProvider.of<CourseBloc>(context).add(UpdateCourse(model));
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
