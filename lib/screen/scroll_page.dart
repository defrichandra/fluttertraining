import 'package:flutter/material.dart';
import 'package:flutter_application_sample_1/helper/locator.dart';
import 'package:flutter_application_sample_1/helper/navigator_service.dart';
import 'package:flutter_application_sample_1/model/create_user.dart';
import 'package:flutter_application_sample_1/screen/dialog.dart';

class MyScrollPage extends StatefulWidget {
  final List<CreateUserModel> listModels;
  MyScrollPage({this.listModels});

  @override
  _MyScrollPageState createState() => _MyScrollPageState();
}

class _MyScrollPageState extends State<MyScrollPage> {
  List<CreateUserModel> listModels = [];
  List<CreateUserModel> searchList = [];

  @override
  void initState() {
    super.initState();
    if (widget.listModels != null) {
      listModels = widget.listModels;
    } else {
      listModels.clear();
      //for (var i = 0; i < 3; i++) {
      for (var i = 0; i < listModels.length; i++) {
        listModels.add(CreateUserModel(
          id: '${i + 1}',
          name: 'Employee Name ${i + 1}',
          job: 'Job ${i + 1}',
          birthDate: DateTime.now(),
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
    search(String value) {
      searchList.clear();
      if (value != null && value != '') {
        setState(() {
          listModels.forEach((element) {
            if (element.name.toUpperCase().contains(value.toUpperCase()) ||
                    element.id.toUpperCase().contains(value.toUpperCase()) ||
                    element.job.toUpperCase().contains(value.toUpperCase())
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

    return Scaffold(
      appBar: AppBar(
        title: Text('List Training'),
      ),
      body: Container(
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
                              //   BlocProvider.of<ProjectBloc>(context)
                              // .add(SearchProject(value));
                            },
                            style: TextStyle(color: Colors.black, fontSize: 12),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(color: Colors.black)),
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
                              .navigateToWithArgmnt('add_list', listModels);
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      //'Employee Name 1',
                                      //listModels[index].name,
                                      searchList[index].name,
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
                                          setState(() {
                                            listModels
                                                .remove(listModels[index]);
                                            searchList.clear();
                                            searchList.addAll(listModels);
                                          });
                                        }),
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      //'Job 1',
                                      //'Job: ${listModels[index].job}',
                                      'Job: ${searchList[index].job}',
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
                                            builder: (BuildContext context) {
                                              return MyListDialogPage(
                                                  listModels[index]);
                                            },
                                          ).then((value) {
                                            if (value != null) {
                                              int idx = listModels.indexWhere(
                                                  (element) =>
                                                      element.id ==
                                                      listModels[index].id);
                                              setState(() {
                                                listModels[idx] = value;
                                                searchList.clear();
                                                searchList.addAll(listModels);
                                              });
                                            }
                                          });
                                        }),
                                  ]),
                              Text(
                                //'Nomor id: 1',
                                //'No Id: ${listModels[index].id}',
                                'No Id: ${searchList[index].id}',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                //'Nomor id: 1',
                                //'Birth Date: ${listModels[index].birthDate}',
                                '${searchList[index].birthDate}',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ]),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
