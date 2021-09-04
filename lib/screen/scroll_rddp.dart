import 'package:flutter/material.dart';
import 'package:flutter_application_sample_1/bloc/bloc/bloc/rddp_bloc.dart';
import 'package:flutter_application_sample_1/bloc/event/rddp_event.dart';
import 'package:flutter_application_sample_1/bloc/state/rddp_state.dart';

import 'package:flutter_application_sample_1/helper/locator.dart';
import 'package:flutter_application_sample_1/helper/navigator_service.dart';
import 'package:flutter_application_sample_1/model/rddp.dart';
import 'package:flutter_application_sample_1/screen/dialog_rddp.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

//tampilan search dan edit atau hapus RDDP
class MyScrollRddpPage extends StatefulWidget {
  final List<Rddp> listModels;
  MyScrollRddpPage({this.listModels});

  @override
  _MyScrollRddpState createState() => _MyScrollRddpState();
}

class _MyScrollRddpState extends State<MyScrollRddpPage> {
  List<Rddp> listModels = [];
  List<Rddp> searchList = [];

  @override
  void initState() {
    super.initState();
    if (widget.listModels != null) {
      listModels = widget.listModels;
    } else {
      listModels.clear();
      //for (var i = 0; i < 3; i++) {
      for (var i = 0; i < listModels.length; i++) {
        listModels.add(Rddp(
          //id: int.parse('${i + 1}'),
          rdddpType: 'Rddp Type ${i + 1}',
          rddpDocName: 'Rddp Name ${i + 1}',
        ));
      }
    }
    searchList.addAll(listModels);
  }

  final TextStyle textstyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  final InputDecoration decoration = InputDecoration(
    border: OutlineInputBorder(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List RDDP'),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => RddpBloc()..add(GetRddp()), //findall
            ),
          ],
          child: BodyScreenRddp(),
        ));
  }
}

class BodyScreenRddp extends StatefulWidget {
  final List<Rddp> listModels;
  BodyScreenRddp({this.listModels});

  @override
  _BodyScreenRddpState createState() => _BodyScreenRddpState();
}

class _BodyScreenRddpState extends State<BodyScreenRddp> {
  List<Rddp> listModels = [];

  List<Rddp> searchList = [];

  void search(String value) {
    searchList.clear();
    if (value != null && value != '') {
      setState(() {
        listModels.forEach((element) {
          if (element.rdddpType.toUpperCase().contains(value.toUpperCase()) ||
              //element.id.toUpperCase().contains(value.toUpperCase()) ||
              element.rddpDocName.toUpperCase().contains(value.toUpperCase())) {
            searchList.add(element);
          }
        });
      });
    } else {
      setState(() {
        searchList.addAll(listModels);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RddpBloc, RddpState>(
      listener: (context, state) {
        if (state is CreateSuccesGet) {
          searchList.clear();
          searchList = state.model;
          searchList.addAll(listModels);
        }
        if (state is SuccessUpdate) {
          BlocProvider.of<RddpBloc>(context).add(GetRddp());
        }
        if (state is SuccessDelete) {
          searchList.clear();
          BlocProvider.of<RddpBloc>(context).add(GetRddp());
        }
      },
      child: BlocBuilder<RddpBloc, RddpState>(
        builder: (context, state) {
          if (state is LoadingRddp) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17, right: 17),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      search(value);
                                    },
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      hintText: 'Search',
                                      hintStyle: TextStyle(fontSize: 15),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.blue,
                                  size: 40,
                                ),
                                onTap: () {
                                  locator<NavigatorService>()
                                      .navigateToWithArgmnt(
                                          'api_rddp', listModels);
                                },
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            //itemCount: listModels.length,
                            itemCount: searchList.length,
                            itemBuilder: (context, index) {
                              final x = searchList[index];
                              return Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.5,
                                    )),
                                height: 150,
                                width: 350,
                                margin: EdgeInsets.all(20),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Project Code: ${x.rddpNo}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.delete_forever_rounded,
                                                  color: Colors.red[300],
                                                ),
                                                onPressed: () {
                                                  BlocProvider.of<RddpBloc>(
                                                          context)
                                                      .add(DeleteRddp(x.id));
                                                }),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Project Name: ${x.projectCode}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: Colors.greenAccent,
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return MyListDialogRddpPage(
                                                          x);
                                                    },
                                                  ).then((value) {
                                                    if (value != null) {
                                                      BlocProvider.of<RddpBloc>(
                                                              context)
                                                          .add(UpdateRddp(
                                                              value));
                                                    }
                                                  });
                                                }),
                                          ]),
                                    ]),
                              );
                            }),
                      ],
                    ),
                  ),
                ));
          }
        },
      ),
    );
  }
}
