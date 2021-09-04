import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_sample_1/bloc/bloc/bloc/sample_bloc.dart';
import 'package:flutter_application_sample_1/bloc/event/sample_event.dart';
import 'package:flutter_application_sample_1/bloc/state/sample_state.dart';
import 'package:flutter_application_sample_1/model/create_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiTestScreen extends StatefulWidget {
  _ApiTestScreenState createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Test API',
          style: TextStyle(color: Colors.white),
        )),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SampleBloc(),
            ),
          ],
          child: ApiTestBody(),
        ));
  }
}

class ApiTestBody extends StatefulWidget {
  _ApiTestBodyState createState() => _ApiTestBodyState();
}

class _ApiTestBodyState extends State<ApiTestBody> {
  CreateUserModel model = CreateUserModel();

  Widget build(BuildContext context) {
    return BlocListener<SampleBloc, SampleState>(
      listener: (context, state) {
        if (state is ApiRequestState) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                duration: Duration(seconds: 3),
                content: Text(
                  'Id baru Anda : ${state.model.id}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.green,
              ),
            );
        } else if (state is ApiRequestError) {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            BlocBuilder<SampleBloc, SampleState>(
              builder: (context, state) {
                if (state is LoadingSample) {
                  return CircularProgressIndicator();
                } else if (state is ApiRequestState) {
                  return Text(
                    'New ID : ${state.model.id}',
                    //'New Job : ${state.model.job}',
                    style: TextStyle(fontSize: 20),
                  );
                } else if (state is ApiRequestError) {
                  return Text(
                    'New ID : ${state.errMsg}',
                    style: TextStyle(fontSize: 20),
                  );
                } else {
                  return Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          decoration: InputDecoration(
                            labelText: 'Name',
                            hintText: 'Input Text',
                          ),
                          // onChanged: (value) {
                          //   model.name = value;
                          // },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Job',
                            hintText: 'Input Text',
                          ),
                          // onChanged: (value) {
                          //   model.job = value;
                          // },
                        ),
                        FlatButton(
                          child: Text(
                            'Create',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          onPressed: () {
                            // BlocProvider.of<SampleBloc>(context).add(RequestApi(
                            //     CreateUserModel(
                            //         name: 'Defri', job: 'Developer')));
                            BlocProvider.of<SampleBloc>(context)
                                .add(RequestApi(model));
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
    );
  }
}
