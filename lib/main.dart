import 'package:flutter/material.dart';
import 'package:flutter_application_sample_1/helper/locator.dart';
//import 'package:flutter_application_sample_1/screen/add_list.dart';
import 'package:flutter_application_sample_1/helper/navigator_service.dart';
import 'package:flutter_application_sample_1/helper/route_generator.dart';
//import 'package:flutter_application_sample_1/screen/api_course.dart';
//import 'package:flutter_application_sample_1/screen/scroll_course.dart';
//import 'package:flutter_application_sample_1/screen/dialog.dart';
// import 'package:flutter_application_sample_1/screen/api_test.dart';
//import 'package:flutter_application_sample_1/screen/scroll_page.dart';
//import 'package:flutter_application_sample_1/screen/first_page.dart';
//import 'package:flutter_application_sample_1/screen/second_page.dart';
//import 'package:flutter_application_sample_1/screen/scroll_project.dart';
//import 'package:flutter_application_sample_1/screen/scroll_rddp.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'API',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: MyHomePage(title: 'Flutter Demo Home Page'),
        //home: MyFirstPage(),
        //home: MySecondPage(),
        //home: ApiTestScreen(),
        //home: MyScrollPage(),
        //home: MyAddListPage(),
        //home: MyListDialogPage();
        // home: MyScrollCoursePage()

        debugShowCheckedModeBanner: false,
        navigatorKey: locator<NavigatorService>().navigatorKey,
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'WELCOME',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'SILAHKAN PILIH:',
            ),
            SizedBox(
              height: 24,
            ),
            FlatButton(
              child: Text(
                'Halaman Project',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              color: Colors.blue,
              //onPressed:() {},
              onPressed: () {
                locator<NavigatorService>().navigateTo('api_project');
              },
            ),
            SizedBox(
              height: 24,
            ),
            FlatButton(
              child: Text(
                'Halaman Rddp',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              color: Colors.blue,
              //onPressed:() {},
              onPressed: () {
                locator<NavigatorService>().navigateTo('api_rddp');
              },
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
