import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:students_register/blocs/cubits.dart';
import 'package:students_register/models/models.dart';
import 'package:students_register/models/student.dart';
import 'package:students_register/widgets/widgets.dart';

import '../locator.dart';

class CForm extends StatefulWidget {
  CForm({
    Key key,
    @required this.student,
  }) : super(key: key);
  final Student student;
  @override
  _CFormState createState() => _CFormState();
}

class _CFormState extends State<CForm> {
  // ContactType _character;
  GlobalKey<FormState> _formKey;
  Student _student;
  bool _isActive;
  int _indexRadio;
  TextEditingController _firtsNameController;
  TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _student = widget.student != null ? widget.student : Student();
    _isActive = widget?.student?.status ?? true;
    _indexRadio = _isActive ? 1 : 2;
    _firtsNameController =
        TextEditingController(text: _student?.firstName ?? '');
    _lastNameController = TextEditingController(text: _student?.lastName ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
        child: BlocConsumer<StudentCubit, StudentState>(
      builder: (context, state) {
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: Responsive.isMobile(context) ? double.infinity : 800,
              padding: EdgeInsets.all(25),
              margin: EdgeInsets.only(bottom: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CTextFormField(
                      controller: _firtsNameController,
                      title: 'Nombre',
                      textInputType: TextInputType.text,
                    ),
                    SizedBox(height: 10),
                    CTextFormField(
                      controller: _lastNameController,
                      title: 'Apellido',
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(height: 10),
                    DropdownButton(
                      hint: widget.student == null
                          ? Text('Seleccione un carrera')
                          : null,
                      value: state.values?.currentValue,
                      isExpanded: true,
                      items: listItem.map((ListItem item) {
                        return DropdownMenuItem(
                          value: item.title,
                          child: Text(item.title),
                        );
                      }).toList(),
                      onChanged: (value) {
                        locator<StudentCubit>().changeValue(
                          value,
                        );
                      },
                    ),
                    if (widget.student != null)
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              groupValue: _indexRadio,
                              value: 1,
                              onChanged: (index) {
                                _indexRadio = index;
                                setState(() {});
                              },
                            ),
                            Text(
                              'Activo',
                              style: TextStyle(fontSize: 18),
                            ),
                            Radio(
                              groupValue: _indexRadio,
                              value: 2,
                              onChanged: (index) {
                                _indexRadio = index;
                                setState(() {});
                              },
                            ),
                            Text(
                              'Inactivo',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 10)
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    final firstName = _firtsNameController?.text;
                    final lastName = _lastNameController?.text;
                    if (widget.student == null) {
                      locator<StudentCubit>().addStudent(
                        _student.copyWith(
                          firstName: firstName,
                          lastName: lastName,
                        ),
                      );
                    } else {
                      locator<StudentCubit>().updateStudent(
                        _student.copyWith(
                            firstName: firstName,
                            lastName: lastName,
                            status: (_indexRadio == 1)),
                      );
                    }
                  }
                },
                color: Colors.blue[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    widget.student != null ? 'ACTUALIZAR' : 'AGREGAR',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 1.4,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
      listener: (context, state) {
        if (state is StudentSuccess) {
          Navigator.pop(context);
        }
      },
    ));
  }
}
