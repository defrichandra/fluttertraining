import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_sample_1/bloc/bloc/bloc/project_bloc.dart';
import 'package:flutter_application_sample_1/bloc/event/project_event.dart';
import 'package:flutter_application_sample_1/bloc/state/project_state.dart';
import 'package:flutter_application_sample_1/helper/locator.dart';
import 'package:flutter_application_sample_1/helper/navigator_service.dart';

import 'package:flutter_application_sample_1/model/project.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Halaman untuk menambah project
class ApiProjectScreen extends StatefulWidget {
  final List<Project> listModels;
  ApiProjectScreen(this.listModels);

  _ApiProjectScreenState createState() => _ApiProjectScreenState();
}

class _ApiProjectScreenState extends State<ApiProjectScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Add Project',
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
                    locator<NavigatorService>().navigateTo('scroll_project');
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
              create: (context) => ProjectBloc(),
            ),
          ],
          child: ApiScreenBody(),
        ));
  }
}

class ApiScreenBody extends StatefulWidget {
  final List<Project> listModels;
  ApiScreenBody({this.listModels});

  _ApiScreenBodyState createState() => _ApiScreenBodyState();
}

class _ApiScreenBodyState extends State<ApiScreenBody> {
  Project model = new Project();
  List<Project> listModels;

  Widget build(BuildContext context) {
    return BlocListener<ProjectBloc, ProjectState>(
        listener: (context, state) {
          if (state is ApiRequestProjectSuccess) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 3),
                  content: Text(
                    'Project Code baru: ${state.model.id}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
          } else if (state is ApiRequestProjectError) {
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
            child: Padding(
                padding: const EdgeInsets.all(25),
                child: ListView(children: <Widget>[
                  BlocBuilder<ProjectBloc, ProjectState>(
                      builder: (context, state) {
                    if (state is LoadingProject) {
                      return CircularProgressIndicator();
                    } else {
                      return Container(
                          padding: const EdgeInsets.all(25),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Create Project',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Project Code',
                                      hintText: 'Input your Project Code',
                                      labelStyle: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                    ),
                                    onChanged: (value) {
                                      model.projectCd = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Project Name',
                                      hintText: 'Input your Project name',
                                      labelStyle: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                    ),
                                    onChanged: (value) {
                                      model.projectName = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      FlatButton(
                                        child: Text(
                                          'Simpan',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.blue,
                                        onPressed: () {
                                          //method dengan api
                                          BlocProvider.of<ProjectBloc>(context)
                                              .add(CreateProject(model));
                                          listModels.add(model);
                                          locator<NavigatorService>()
                                              .navigateToWithArgmnt(
                                                  'scroll_project', listModels);
                                        },
                                      ),
                                    ],
                                  ),
                                ]),
                          ));
                    }
                  })
                ]))));
  }
}
