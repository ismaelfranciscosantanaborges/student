import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:students_register/blocs/cubits.dart';
import 'package:students_register/locator.dart';
import 'package:students_register/models/list_item.dart';
import 'package:students_register/models/models.dart';
import 'package:students_register/pages/add_and_update_student.dart';
import 'package:students_register/widgets/search_delegate.dart';
import 'package:students_register/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  static final String route = 'HomePage';
  List<Student> students;
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Studiante'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CSearchDelegate(
                  locator<StudentCubit>().state.values.students,
                ),
              );
            },
          )
        ],
      ),
      body: BlocConsumer<StudentCubit, StudentState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case StudentsInitial:
              return Center(
                child: Text('initial'),
              );
              break;
            case StudentLoading:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            default:
              return Column(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Introduzca una carrera ...',
                      ),
                    ),
                  ),
                  if (state.values.students.length > 0)
                    Container(
                      child: ListView.builder(
                        itemCount: state.values?.students?.length ?? 0,
                        itemBuilder: (context, index) {
                          final student = state.values.students[index];
                          return CListTile(
                            student: student,
                            index: index,
                          );
                        },
                      ),
                    ),
                ],
              );
              return Container(
                child: Center(
                  child: Text('La lista esta vacia'),
                ),
              );
              break;
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddAndUpdateStuden.route);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
