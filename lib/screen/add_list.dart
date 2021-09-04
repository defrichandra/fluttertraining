import 'package:flutter/material.dart';
import 'package:flutter_application_sample_1/helper/locator.dart';
import 'package:flutter_application_sample_1/helper/navigator_service.dart';
import 'package:flutter_application_sample_1/model/create_user.dart';
import 'package:intl/intl.dart';

class MyAddListPage extends StatefulWidget {
  final List<CreateUserModel> listModels;
  MyAddListPage(this.listModels);

  @override
  _MyAddListPageState createState() => _MyAddListPageState();
}

class _MyAddListPageState extends State<MyAddListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add to List'),
      ),
      body: AddListBody(listModels: widget.listModels),
    );
  }
}

class AddListBody extends StatefulWidget {
  final List<CreateUserModel> listModels;
  AddListBody({this.listModels});

  @override
  _AddListBodyState createState() => _AddListBodyState();
}

class _AddListBodyState extends State<AddListBody> {
  CreateUserModel model = new CreateUserModel();
  List<CreateUserModel> listModels;

  TextEditingController dateCo = new TextEditingController();
  DateTime initialDate = DateTime.now();
  DateFormat formatter = DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    dateCo = new TextEditingController();
    if (widget.listModels != null) {
      listModels = widget.listModels;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            'Create User',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.black, fontSize: 12),
            decoration: InputDecoration(
              labelText: 'Name',
              hintText: 'Name',
              labelStyle: TextStyle(color: Colors.black, fontSize: 15),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.black)),
            ),
            onChanged: (value) {
              model.name = value;
            },
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
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
                isDense: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: TextStyle(fontSize: 16, color: Colors.grey[200]),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.black)),
              ),
            ),
          ),
          TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.black)),
                labelText: 'Birth Date',
                labelStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
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
              }),
          FlatButton(
            child: Text(
              'Add New Data',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            onPressed: () {
              //model.id = '${listModels.length + 1}';
              if (listModels.isNotEmpty) {
                CreateUserModel lastModel = listModels.last;
                String lastId = lastModel.id;
                int lastIdInt = int.parse(lastId);
                model.id = '${lastIdInt + 1}';
              } else {
                model.id = '1';
              }
              listModels.add(model);
              locator<NavigatorService>()
                  .navigateToWithArgmnt('scroll_page', listModels);
            },
          ),
        ],
      ),
    );
  }
}
