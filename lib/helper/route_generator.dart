import 'package:flutter/material.dart';
import 'package:flutter_application_sample_1/helper/locator.dart';
import 'package:flutter_application_sample_1/helper/navigator_service.dart';
import 'package:flutter_application_sample_1/main.dart';
import 'package:flutter_application_sample_1/model/course.dart';
import 'package:flutter_application_sample_1/model/create_user.dart';
import 'package:flutter_application_sample_1/model/project.dart';
import 'package:flutter_application_sample_1/model/rddp.dart';
import 'package:flutter_application_sample_1/screen/add_list.dart';
import 'package:flutter_application_sample_1/screen/api_course.dart';
import 'package:flutter_application_sample_1/screen/api_project.dart';
import 'package:flutter_application_sample_1/screen/api_rddp.dart';

import 'package:flutter_application_sample_1/screen/first_page.dart';
import 'package:flutter_application_sample_1/screen/scroll_course.dart';
import 'package:flutter_application_sample_1/screen/scroll_page.dart';
import 'package:flutter_application_sample_1/screen/scroll_project.dart';
import 'package:flutter_application_sample_1/screen/scroll_rddp.dart';
import 'package:flutter_application_sample_1/screen/second_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'first_page':
        return MaterialPageRoute(builder: (_) => MyFirstPage());
        break;
      case 'second_page':
        return MaterialPageRoute(builder: (_) => MySecondPage());
        break;
      case 'scroll_page':
        List<CreateUserModel> arg = settings.arguments;
        return MaterialPageRoute(builder: (_) => MyScrollPage(listModels: arg));
        break;
      case 'add_list':
        List<CreateUserModel> arg = settings.arguments;
        return MaterialPageRoute(builder: (_) => MyAddListPage(arg));
        break;

      case 'api_course':
        List<Course> arg = settings.arguments;
        return MaterialPageRoute(builder: (_) => ApiCourseScreen(arg));
        break;

      case 'scroll_course':
        List<Course> arg = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => MyScrollCoursePage(listModels: arg));
        break;
////////////////////////////////////////////////////////////////////////////////////////////////

      case 'scroll_project':
        List<Project> arg = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => MyScrollProjectPage(listModels: arg));
        break;

      case 'api_project':
        List<Project> arg = settings.arguments;
        return MaterialPageRoute(builder: (_) => ApiProjectScreen(arg));
        break;

      case 'scroll_rddp':
        List<Rddp> arg = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => MyScrollRddpPage(listModels: arg));
        break;

      case 'api_rddp':
        List<Rddp> arg = settings.arguments;
        return MaterialPageRoute(builder: (_) => ApiRddpScreen(arg));
        break;

      case 'main':
        return MaterialPageRoute(builder: (_) => MyApp());
        break;

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('This is Error Page'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Route Generator is error, back to first page'),
            Container(
              margin: EdgeInsets.all(4),
            ),
            GestureDetector(
              onTap: () {
                locator<NavigatorService>().navigateReplaceTo('first_page');
              },
              child: Icon(Icons.refresh),
            )
          ],
        )),
      );
    });
  }
}
