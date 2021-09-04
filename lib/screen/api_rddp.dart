import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_sample_1/bloc/bloc/bloc/rddp_bloc.dart';
import 'package:flutter_application_sample_1/bloc/event/rddp_event.dart';
import 'package:flutter_application_sample_1/bloc/state/rddp_state.dart';

import 'package:flutter_application_sample_1/helper/locator.dart';
import 'package:flutter_application_sample_1/helper/navigator_service.dart';
import 'package:flutter_application_sample_1/model/rddp.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ApiRddpScreen extends StatefulWidget {
  final List<Rddp> listModels;
  ApiRddpScreen(this.listModels);

  _ApiRddpScreenState createState() => _ApiRddpScreenState();
}

class _ApiRddpScreenState extends State<ApiRddpScreen> {
  List<Rddp> listModels = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Add Rddp',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              PopupMenuButton(
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("Halaman Utama"),
                    value: 0,
                  ),
                  PopupMenuItem(
                    child: Text("Lihat Data"),
                    value: 1,
                  ),
                  // PopupMenuItem(
                  //   child: Text("Edit Data"),
                  //   value: 2,
                  // ),
                ],
                onSelected: (value) {
                  if (value == 0) {
                    locator<NavigatorService>().navigateTo('main');
                  }
                  if (value == 1) {
                    locator<NavigatorService>().navigateTo('scroll_rddp');
                  }
                  //   if (value == 2) {
                  //     showDialog(context: context,
                  //     builder: (BuildContext context) {
                  //       return MyListDialogRddpPage(x);
                  //   };
                },
              ),
            ]),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => RddpBloc(),
            ),
          ],
          child: ApiRddpBody(),
        ));
  }
}

class ApiRddpBody extends StatefulWidget {
  final List<Rddp> listModels;

  ApiRddpBody({this.listModels});

  _ApiRddpBodyState createState() => _ApiRddpBodyState();
}

class _ApiRddpBodyState extends State<ApiRddpBody> {
  Rddp model = new Rddp();
  List<Rddp> listModels;

  int radioValue = 0;
  int valueRadio = 0;
  bool checkBoxY = false;
  bool checkBoxN = false;
  bool checkBoxO = false;

  TextEditingController asaDt;
  TextEditingController dcsDt;
  TextEditingController rddpDt;
  TextEditingController suppSendDt;
  TextEditingController supRcvDt;

  DateTime initialDate = DateTime.now();
  DateFormat formatter = DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    //model = widget.model;

    asaDt = new TextEditingController();
    dcsDt = new TextEditingController();
    suppSendDt = new TextEditingController();
    rddpDt = new TextEditingController();
    supRcvDt = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RddpBloc, RddpState>(
      listener: (context, state) {
        if (state is ApiRequestRddpSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                duration: Duration(seconds: 3),
                content: Text(
                  'Rddp Id baru Anda: ${state.model.id}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.green,
              ),
            );
        } else if (state is ApiRequestRddpError) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                duration: Duration(seconds: 3),
                content: Text(
                  state.errMsg ?? 'Terjadi Kesalahan...',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
        } else {
          return Container();
        }
      },
      child: Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              BlocBuilder<RddpBloc, RddpState>(
                builder: (context, state) {
                  if (state is LoadingRddp) {
                    return CircularProgressIndicator();
                  } else {
                    return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                            child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Create Rddp',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'RDDP No',
                                  hintText: 'Input Text',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                ),
                                onChanged: (value) {
                                  model.rddpNo = value;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    labelText: 'RDDP Date',
                                    labelStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  readOnly: true,
                                  controller: rddpDt,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime(1800),
                                      lastDate: DateTime.now(),
                                    ).then((date) {
                                      if (date != null) {
                                        rddpDt.text = formatter.format(date);
                                        initialDate = date;
                                        model.rddpDt = date;
                                      }
                                    });
                                  }),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('RDDP Type :'),
                                  Radio(
                                      value: 1,
                                      groupValue: radioValue,
                                      onChanged: (value) {
                                        model.rdddpType = 'Project';
                                        setState(() {
                                          radioValue = value;
                                        });
                                      }),
                                  Text('Project'),
                                  Radio(
                                      value: 2,
                                      groupValue: radioValue,
                                      onChanged: (value) {
                                        model.rdddpType = 'Regular';
                                        setState(() {
                                          radioValue = value;
                                        });
                                      }),
                                  Text('Regular'),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  hint: Text(
                                    'Project Code',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  isExpanded: true,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('650A'),
                                      value: '650A',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('660A'),
                                      value: '660A',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('230B'),
                                      value: '230B',
                                    )
                                  ],
                                  onChanged: (value) {
                                    model.projectCode = value;
                                  },
                                  decoration: InputDecoration(
                                    isDense: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                        fontSize: 16, color: Colors.grey[200]),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  hint: Text(
                                    'Car Family',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  isExpanded: true,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('453W'),
                                      value: '453W',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('454W'),
                                      value: '454W',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('513W'),
                                      value: '513W',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('455W'),
                                      value: '455W',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('456W'),
                                      value: '456W',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('457W'),
                                      value: '457W',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('458W'),
                                      value: '458W',
                                    )
                                  ],
                                  onChanged: (value) {
                                    model.carFamilyId = value;
                                  },
                                  decoration: InputDecoration(
                                    isDense: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                        fontSize: 16, color: Colors.grey[200]),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  hint: Text(
                                    'Design Code',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  isExpanded: true,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('BM201'),
                                      value: 'BM201',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('DD102'),
                                      value: 'DD102',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('DD403'),
                                      value: 'DD403',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('DD601'),
                                      value: 'DD601',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('DDC04'),
                                      value: 'DDC04',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('DE100'),
                                      value: 'DE100',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('DE350'),
                                      value: 'DE350',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('DE430'),
                                      value: 'DE430',
                                    ),
                                  ],
                                  onChanged: (value) {
                                    model.designId = value;
                                  },
                                  decoration: InputDecoration(
                                    isDense: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                        fontSize: 16, color: Colors.grey[200]),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  hint: Text(
                                    'Issued Base',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  isExpanded: true,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('TMC'),
                                      value: 'TMC',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('TMMIN'),
                                      value: 'TMMIN',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('ECR'),
                                      value: 'ECR',
                                    ),
                                  ],
                                  onChanged: (value) {
                                    model.issuedBy = value;
                                  },
                                  decoration: InputDecoration(
                                    isDense: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                        fontSize: 16, color: Colors.grey[200]),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    labelText: 'TMC To Supplier',
                                    labelStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  readOnly: true,
                                  controller: suppSendDt,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime(1800),
                                      lastDate: DateTime.now(),
                                    ).then((date) {
                                      if (date != null) {
                                        rddpDt.text = formatter.format(date);
                                        initialDate = date;
                                        model.suppSendDt = date;
                                      }
                                    });
                                  }),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('DCS Doc:'),
                                  Radio(
                                      value: 1,
                                      groupValue: valueRadio,
                                      onChanged: (value) {
                                        model.dcsDoc = 'Required';
                                        setState(() {
                                          valueRadio = value;
                                        });
                                      }),
                                  Text('Required'),
                                  Radio(
                                      value: 2,
                                      groupValue: valueRadio,
                                      onChanged: (value) {
                                        model.dcsDoc = 'Not Required';
                                        setState(() {
                                          valueRadio = value;
                                        });
                                      }),
                                  Text('Not Required'),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    labelText: 'DCS Receive Due Date',
                                    labelStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  readOnly: true,
                                  controller: dcsDt,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime(1800),
                                      lastDate: DateTime.now(),
                                    ).then((date) {
                                      if (date != null) {
                                        rddpDt.text = formatter.format(date);
                                        initialDate = date;
                                        model.dcsRcvDueDt = date;
                                      }
                                    });
                                  }),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'ECI Number',
                                  hintText: 'Input Text',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                ),
                                onChanged: (value) {
                                  model.eciNo = value;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  hint: Text(
                                    'Supplier Code',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  isExpanded: true,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('5011'),
                                      value: '5011',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('5021'),
                                      value: '5021',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('5035'),
                                      value: '5035',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('5148'),
                                      value: '5148',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('5000'),
                                      value: '5000',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('5304'),
                                      value: '5304',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('5365'),
                                      value: '5365',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('5007'),
                                      value: '5007',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('5035'),
                                      value: '5035',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('5035'),
                                      value: '5035',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('5005'),
                                      value: '5005',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('5263'),
                                      value: '5263',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('5024'),
                                      value: '5024',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('5366'),
                                      value: '5366',
                                    ),
                                  ],
                                  onChanged: (value) {
                                    model.supplierId = value;
                                  },
                                  decoration: InputDecoration(
                                    isDense: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                        fontSize: 16, color: Colors.grey[200]),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Designer Name',
                                  hintText: 'Input Text',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                ),
                                onChanged: (value) {
                                  model.designerName = value;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    labelText: 'ASA Receive Due Date',
                                    labelStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  readOnly: true,
                                  controller: asaDt,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime(1800),
                                      lastDate: DateTime.now(),
                                    ).then((date) {
                                      if (date != null) {
                                        rddpDt.text = formatter.format(date);
                                        initialDate = date;
                                        model.asaRcvDueDt = date;
                                      }
                                    });
                                  }),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    labelText: 'Supplier Receive Due Date',
                                    labelStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  readOnly: true,
                                  controller: supRcvDt,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: initialDate,
                                      firstDate: DateTime(1800),
                                      lastDate: DateTime.now(),
                                    ).then((date) {
                                      if (date != null) {
                                        rddpDt.text = formatter.format(date);
                                        initialDate = date;
                                        model.supRcvDt = date;
                                      }
                                    });
                                  }),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('3D Data Format:'),
                                  Radio(
                                      value: 1,
                                      groupValue: radioValue,
                                      onChanged: (value) {
                                        model.threeD = 'Catia V5';
                                        setState(() {
                                          radioValue = value;
                                        });
                                      }),
                                  Text('Catia V5'),
                                  Radio(
                                      value: 2,
                                      groupValue: radioValue,
                                      onChanged: (value) {
                                        model.dcsDoc = 'Pro/E';
                                        setState(() {
                                          radioValue = value;
                                        });
                                      }),
                                  Text('Pro/E'),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Column(
                                children: <Widget>[
                                  Text('Submitting Format:'),
                                  CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: checkBoxY,
                                    onChanged: (value) {
                                      if (value) {
                                        model.docFormat =
                                            'Data As Master (3D+2D)';
                                      } else {
                                        model.docFormat = null;
                                      }
                                      setState(() {
                                        checkBoxY = value;
                                        checkBoxN = false;
                                        checkBoxO = false;
                                      });
                                    },
                                    title: Text('Data As Master (3D+2D)'),
                                  ),
                                  CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: checkBoxN,
                                    onChanged: (value) {
                                      if (value) {
                                        model.docFormat = 'Data As Master (2D)';
                                      } else {
                                        model.docFormat = null;
                                      }
                                      setState(() {
                                        checkBoxN = value;
                                        checkBoxY = false;
                                      });
                                    },
                                    title: Text('Data As Master (2D)'),
                                  ),
                                  CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: checkBoxO,
                                    onChanged: (value) {
                                      if (value) {
                                        model.docFormat =
                                            'Paper As Master (2D)';
                                      } else {
                                        model.docFormat = null;
                                      }
                                      setState(() {
                                        checkBoxO = value;
                                        checkBoxY = false;
                                        checkBoxN = false;
                                      });
                                    },
                                    title: Text('Paper As Master (2D)'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'RDDP Doc',
                                  hintText: 'Input Text',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                ),
                                onChanged: (value) {
                                  model.rddpDocName = value;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  FlatButton(
                                    child: Text(
                                      'Create',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.blue,
                                    onPressed: () {
                                      //method dengan api
                                      BlocProvider.of<RddpBloc>(context)
                                          .add(CreateRddp(model));
                                      listModels.add(model);
                                      locator<NavigatorService>()
                                          .navigateToWithArgmnt(
                                              'scroll_rddp', listModels);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )));
                  }
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
