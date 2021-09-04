import 'package:flutter/material.dart';
import 'package:flutter_application_sample_1/bloc/bloc/bloc/project_bloc.dart';
import 'package:flutter_application_sample_1/bloc/event/project_event.dart';

import 'package:flutter_application_sample_1/helper/locator.dart';
import 'package:flutter_application_sample_1/helper/navigator_service.dart';
import 'package:flutter_application_sample_1/model/project.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyListDialogProjectPage extends StatefulWidget {
  final Project model;
  const MyListDialogProjectPage(this.model);

  @override
  _MyDialogPageState createState() => _MyDialogPageState();
}

class _MyDialogPageState extends State<MyListDialogProjectPage> {
  Project model;

  TextEditingController nameCo;
  TextEditingController codeCo;

  @override
  void initState() {
    super.initState();
    model = widget.model;
    codeCo = new TextEditingController();
    nameCo = new TextEditingController();

    codeCo.value = codeCo.value.copyWith(text: model.projectCd);
    nameCo.value = nameCo.value.copyWith(text: model.projectName);
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
                'Update Project',
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
                  model.projectCd = value;
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
                  labelText: 'Project Code',
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
                onChanged: (value) {
                  model.projectName = value;
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
                  labelText: 'Project Name',
                  labelStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              FlatButton(
                child: Text(
                  'Update Project',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  BlocProvider.of<ProjectBloc>(context)
                      .add(UpdateProject(model));
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
