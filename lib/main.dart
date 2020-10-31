import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:students_register/blocs/cubits.dart';
import 'package:students_register/locator.dart';
import 'package:students_register/pages/add_and_update_student.dart';

import 'pages/home_page.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentCubit>.value(
      value: locator()..getStudents(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: HomePage.route,
        routes: {
          HomePage.route: (context) => HomePage(),
          AddAndUpdateStuden.route: (context) => AddAndUpdateStuden()
        },
      ),
    );
  }
}
