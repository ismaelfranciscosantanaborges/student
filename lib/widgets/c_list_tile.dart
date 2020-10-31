import 'package:flutter/material.dart';
import 'package:students_register/blocs/cubits.dart';
import 'package:students_register/locator.dart';
import 'package:students_register/models/models.dart';
import 'package:students_register/pages/pages.dart';

class CListTile extends StatelessWidget {
  const CListTile(
      {Key key, @required this.student, @required this.index, this.onPress})
      : super(key: key);

  final Student student;
  final int index;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: index % 2 == 0 ? Colors.white : Colors.grey.withOpacity(.2),
      child: ListTile(
        onTap: onPress != null
            ? onPress
            : () {
                locator<StudentCubit>().changeValue(student.career);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddAndUpdateStuden(
                      student: student,
                    ),
                  ),
                );
              },
        trailing: Container(
          width: 65,
          decoration: BoxDecoration(
              border: Border.all(
                  color: student.status ? Colors.green : Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.all(5),
          child: Text(
            student.status ? 'Activo' : 'Inactivo',
            style: TextStyle(
              color: student.status ? Colors.green : Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        title: Text(
          '${student.firstName} ${student.lastName}',
        ),
        subtitle: Text('${student.career}'),
      ),
    );
  }
}
