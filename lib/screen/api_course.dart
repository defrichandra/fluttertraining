import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_sample_1/bloc/bloc/bloc/course_bloc.dart';
import 'package:flutter_application_sample_1/bloc/event/course_event.dart';

import 'package:flutter_application_sample_1/bloc/state/course_state.dart';
import 'package:flutter_application_sample_1/helper/locator.dart';
import 'package:flutter_application_sample_1/helper/navigator_service.dart';

import 'package:flutter_application_sample_1/model/course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiCourseScreen extends StatefulWidget {
  final List<Course> listModels;
  ApiCourseScreen(this.listModels);

  _ApiCourseScreenState createState() => _ApiCourseScreenState();
}

class _ApiCourseScreenState extends State<ApiCourseScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Add Course',
          style: TextStyle(color: Colors.white),
        )),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CourseBloc(),
            ),
          ],
          child: ApiCourseBody(),
        ));
  }
}

class ApiCourseBody extends StatefulWidget {
  final List<Course> listModels;
  ApiCourseBody({this.listModels});

  _ApiCourseBodyState createState() => _ApiCourseBodyState();
}

class _ApiCourseBodyState extends State<ApiCourseBody> {
  Course model = new Course();
  List<Course> listModels;

  // int radioValue = 0;
  // bool checkBoxY = false;
  // bool checkBoxN = false;

  Widget build(BuildContext context) {
    return BlocListener<CourseBloc, CourseState>(
      listener: (context, state) {
        if (state is ApiRequestCourseSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                duration: Duration(seconds: 3),
                content: Text(
                  'Course Id baru: ${state.model.id}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.green,
              ),
            );
        } else if (state is ApiRequestCourseError) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              BlocBuilder<CourseBloc, CourseState>(
                builder: (context, state) {
                  if (state is LoadingCourse) {
                    return CircularProgressIndicator();
                  } else {
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
                            'Create Course',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Course Code',
                              hintText: 'Input Text',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 15),
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
                              model.courseCode = value;
                            },
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              hint: Text(
                                'Course Name',
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
                                )
                              ],
                              onChanged: (value) {
                                model.courseName = value;
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
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Course Description',
                              hintText: 'Input Text',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 15),
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
                              model.courseDesc = value;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.,]+'))
                            ],
                            decoration: InputDecoration(
                              labelText: 'SKS',
                              hintText: 'Input Text',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 15),
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
                              model.credits = int.parse(value);
                            },
                          ),
                          FlatButton(
                            child: Text(
                              'Create',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              //method hardcode
                              // BlocProvider.of<SampleBloc>(context).add(RequestApi(
                              //     CreateUserModel(
                              //         name: 'Defri', job: 'Developer')));
                              // BlocProvider.of<SampleBloc>(context)
                              //     .add(RequestApi(model));
                              // BlocProvider.of<CourseBloc>(context)
                              //     .add(RequestApiCourse(Course(
                              //   courseCode: 'c9',
                              //   courseDesc: "baru",
                              //   courseName: "ksdallsakd",
                              //   credits: 2,
                              //   //id: 0
                              // )));

                              //Method tanpa api dan membuat id + 1 dari id terakhir yang ada di list model
                              // if (listModels.isNotEmpty) {
                              //   Course lastModel = listModels.last;
                              //   String lastId = '${lastModel.id}';
                              //   int lastIdInt = int.parse(lastId);
                              //   model.id = lastIdInt + 1;
                              // } else {
                              //   model.id = 1;
                              // }
                              //listModels.add(model);
                              //  locator<NavigatorService>().navigateToWithArgmnt(
                              //     'scroll_course', listModels);

                              //method dengan api
                              BlocProvider.of<CourseBloc>(context)
                                  .add(CreateCourse(model));
                              listModels.add(model);
                              locator<NavigatorService>().navigateToWithArgmnt(
                                  'scroll_course', listModels);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
