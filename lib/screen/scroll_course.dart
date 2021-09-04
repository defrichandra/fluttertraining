import 'package:flutter/material.dart';
import 'package:flutter_application_sample_1/bloc/bloc/bloc/course_bloc.dart';
import 'package:flutter_application_sample_1/bloc/event/course_event.dart';
import 'package:flutter_application_sample_1/bloc/state/course_state.dart';
import 'package:flutter_application_sample_1/helper/locator.dart';
import 'package:flutter_application_sample_1/helper/navigator_service.dart';
import 'package:flutter_application_sample_1/model/course.dart';

import 'package:flutter_application_sample_1/screen/dialog_course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:http/http.dart';

class MyScrollCoursePage extends StatefulWidget {
  final List<Course> listModels;
  MyScrollCoursePage({this.listModels});

  @override
  _MyScrollPageState createState() => _MyScrollPageState();
}

class _MyScrollPageState extends State<MyScrollCoursePage> {
  List<Course> listModels = [];
  List<Course> searchList = [];

  @override
  void initState() {
    super.initState();
    if (widget.listModels != null) {
      listModels = widget.listModels;
    } else {
      listModels.clear();
      //for (var i = 0; i < 3; i++) {
      for (var i = 0; i < listModels.length; i++) {
        listModels.add(Course(
          id: int.parse('${i + 1}'),
          credits: int.parse('${i + 1}'),
          courseName: 'Course Name ${i + 1}',
          courseCode: 'Course Code ${i + 1}',
          courseDesc: 'Course Description ${i + 1}',
          //birthDate: DateTime.now(),
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
          title: Text('List Course'),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CourseBloc()..add(GetCourse()), //findall
            ),
          ],
          child: BodyScreenCourse(),
        ));
  }
}

class BodyScreenCourse extends StatefulWidget {
  final List<Course> listModels;
  BodyScreenCourse({this.listModels});

  @override
  _BodyScreenCourseState createState() => _BodyScreenCourseState();
}

class _BodyScreenCourseState extends State<BodyScreenCourse> {
  List<Course> listModels = [];

  List<Course> searchList = [];

  void search(String value) {
    searchList.clear();
    if (value != null && value != '') {
      setState(() {
        listModels.forEach((element) {
          if (element.courseCode.toUpperCase().contains(value.toUpperCase()) ||
                  //element.id.toUpperCase().contains(value.toUpperCase()) ||
                  element.courseDesc
                      .toUpperCase()
                      .contains(value.toUpperCase()) ||
                  element.courseName.toUpperCase().contains(value.toUpperCase())
              //|| element.birthDate.toUpperCase().contains(value.toUpperCase())

              ) {
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
    return BlocListener<CourseBloc, CourseState>(
      listener: (context, state) {
        // if (state is CourseInitial) {
        //   BlocProvider.of<CourseBloc>(context).add(GetCourse());
        // }
        if (state is CreateSuccesGet) {
          searchList.clear();
          searchList = state.model;
          searchList.addAll(listModels);
        }
        if (state is SuccessUpdate) {
          BlocProvider.of<CourseBloc>(context).add(GetCourse());
        }
        if (state is SuccessDelete) {
          searchList.clear();
          BlocProvider.of<CourseBloc>(context).add(GetCourse());
        }
      },
      child: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is LoadingCourse) {
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
                                      //   BlocProvider.of<CourseBloc>(context)
                                      // .add(SearchCourse(value));
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
                                          'api_course', listModels);
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
                                              'Course Code: ${x.courseCode}',
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
                                                onPressed: ()
                                                    // {
                                                    //   setState(() {
                                                    //     listModels
                                                    //         .remove(listModels[index]);
                                                    //     searchList.clear();
                                                    //     searchList.addAll(listModels);
                                                    //   });
                                                    // }
                                                    {
                                                  BlocProvider.of<CourseBloc>(
                                                          context)
                                                      .add(DeleteCourse(x.id));
                                                }),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Course Name: ${x.courseName}',
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
                                                      return MyListDialogCoursePage(
                                                          x);
                                                    },
                                                  ).then((value) {
                                                    if (value != null) {
                                                      BlocProvider.of<
                                                                  CourseBloc>(
                                                              context)
                                                          .add(UpdateCourse(
                                                              value));
                                                      // int idx =
                                                      //     listModels.indexWhere(
                                                      //         (element) =>
                                                      //             element.id ==
                                                      //             listModels[
                                                      //                     index]
                                                      //                 .id);
                                                      // setState(() {
                                                      //   listModels[idx] = value;
                                                      //   searchList.clear();
                                                      //   searchList
                                                      //       .addAll(listModels);
                                                      // });
                                                    }
                                                  });
                                                }),
                                          ]),
                                      Text(
                                        'Course Desc: ${x.courseDesc}',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        'SKS: ${x.credits}',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      // Text(
                                      //   //'Nomor id: 1',
                                      //   //'Birth Date: ${listModels[index].birthDate}',
                                      //   '${searchList[index].birthDate}',
                                      //   style: TextStyle(
                                      //       fontSize: 10,
                                      //       fontWeight: FontWeight.bold,
                                      //       color: Colors.black),
                                      // ),
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
