import 'package:flutter/material.dart';
import 'package:students_register/blocs/cubits.dart';
import 'package:students_register/locator.dart';
import 'package:students_register/models/models.dart';
import 'package:students_register/widgets/widgets.dart';

class AddAndUpdateStuden extends StatelessWidget {
  AddAndUpdateStuden({Key key, this.student}) : super(key: key);
  final Student student;
  static const String route = 'AddAndUpdateStuden';

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Studiante'),
        actions: [
          if (student != null)
            IconButton(
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                ),
                onPressed: () {
                  locator<StudentCubit>().deleteStudents(student.id);
                })
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: _screenSize.width * .05),
        color: Colors.blue,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              student == null
                  ? 'Agregando Estudiante'
                  : 'Actualizando Estudiante',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            CForm(student: student),
          ],
        ),
      ),
    );
  }
}
