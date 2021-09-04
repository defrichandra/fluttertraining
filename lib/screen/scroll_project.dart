import 'package:flutter/material.dart';
import 'package:flutter_application_sample_1/bloc/bloc/bloc/project_bloc.dart';
import 'package:flutter_application_sample_1/bloc/event/project_event.dart';
import 'package:flutter_application_sample_1/bloc/state/project_state.dart';
import 'package:flutter_application_sample_1/helper/locator.dart';
import 'package:flutter_application_sample_1/helper/navigator_service.dart';
import 'package:flutter_application_sample_1/model/project.dart';

import 'package:flutter_application_sample_1/screen/dialog_project.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//tampilan search dan edit atau hapus Project
class MyScrollProjectPage extends StatefulWidget {
  final List<Project> listModels;
  MyScrollProjectPage({this.listModels});

  @override
  _MyScrollProjectState createState() => _MyScrollProjectState();
}

class _MyScrollProjectState extends State<MyScrollProjectPage> {
  List<Project> listModels = [];
  List<Project> searchList = [];

  @override
  void initState() {
    super.initState();
    if (widget.listModels != null) {
      listModels = widget.listModels;
    } else {
      listModels.clear();
      //for (var i = 0; i < 3; i++) {
      for (var i = 0; i < listModels.length; i++) {
        listModels.add(Project(
          id: int.parse('${i + 1}'),
          projectCd: 'Project Code ${i + 1}',
          projectName: 'Project Name ${i + 1}',
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
          title: Text('List Project'),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ProjectBloc()..add(GetProject()),
            ),
          ],
          child: BodyScreenProject(),
        ));
  }
}

class BodyScreenProject extends StatefulWidget {
  final List<Project> listModels;
  BodyScreenProject({this.listModels});

  @override
  _BodyScreenProjectState createState() => _BodyScreenProjectState();
}

class _BodyScreenProjectState extends State<BodyScreenProject> {
  List<Project> listModels = [];

  List<Project> searchList = [];

  void search(String value) {
    searchList.clear();
    if (value != null && value != '') {
      setState(() {
        listModels.forEach((element) {
          if (element.projectCd.toUpperCase().contains(value.toUpperCase()) ||
              element.projectName.toUpperCase().contains(value.toUpperCase())) {
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
    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is CreateSuccesGet) {
          searchList.clear();
          searchList = state.model;
          searchList.addAll(listModels);
        }
        if (state is SuccessUpdate) {
          BlocProvider.of<ProjectBloc>(context).add(GetProject());
        }
        if (state is SuccessDelete) {
          searchList.clear();
          BlocProvider.of<ProjectBloc>(context).add(GetProject());
        }
      },
      child: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          if (state is LoadingProject) {
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
                                          'api_project', listModels);
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
                                height: 450,
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
                                              'Project Code: ${x.projectCd}',
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
                                                  BlocProvider.of<ProjectBloc>(
                                                          context)
                                                      .add(DeleteProject(x.id));
                                                }),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Project Name: ${x.projectName}',
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
                                                      return MyListDialogProjectPage(
                                                          x);
                                                    },
                                                  ).then((value) {
                                                    if (value != null) {
                                                      BlocProvider.of<
                                                                  ProjectBloc>(
                                                              context)
                                                          .add(UpdateProject(
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
