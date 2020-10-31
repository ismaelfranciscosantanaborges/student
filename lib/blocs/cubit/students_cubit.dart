import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:students_register/models/student.dart';
import 'package:students_register/repositories/student_api_client.dart';

part 'students_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit(StudentApiClient api)
      : this._api = api,
        super(StudentsInitial(StudentValues()));

  final StudentApiClient _api;

  void init() {}

  Future<void> getStudents() async {
    emit(StudentLoading(state.values));

    final response = await _api.getStudents();

    if (response.status == 200) {
      List students = response.data.map((student) {
        return Student.fromMap(student);
      }).toList();

      emit(StudentSuccess(state.values.copyWith(students: students)));
    } else {
      emit(StudentSuccess(
        state.values.copyWith(errorMessage: 'The api return error'),
      ));
    }
  }

  Future<void> addStudent(Student student) async {
    if (state.values.currentValue == null) return;

    emit(StudentLoading(state.values));

    final response = await _api.postStudents(
      student.copyWith(career: state.values.currentValue, status: true).toMap(),
    );

    if (response.status == 200) {
      List<Student> students = state.values.students;
      students.add(Student.fromMap(response.data));
      emit(StudentSuccess(state.values.copyWith(students: students)));
    } else {
      emit(StudentSuccess(
        state.values.copyWith(errorMessage: 'The api return error'),
      ));
    }
  }

  Future<void> updateStudent(Student student) async {
    if (state.values.currentValue == null) return;

    emit(StudentLoading(state.values));

    final response = await _api.putStudents(
      student.id,
      student.copyWith(career: state.values.currentValue).toMap(),
    );

    if (response.status == 200) {
      final currentStudent = state.values.students
          .firstWhere((element) => element.id == student.id);

      List<Student> students = state.values.students.map((pStudent) {
        if (currentStudent.id == student.id)
          return student.copyWith(
            career: state.values.currentValue,
          );
        return pStudent;
      }).toList();
      emit(StudentSuccess(state.values.copyWith(students: students)));
    } else {
      emit(StudentSuccess(
        state.values.copyWith(errorMessage: 'The api return error'),
      ));
    }
  }

  Future<void> deleteStudents(String studentId) async {
    if (state.values.currentValue == null) return;

    emit(StudentLoading(state.values));

    final response = await _api.deleteStudents(studentId);

    if (response.status == 200) {
      List<Student> students = [];
      if (state.values.students.length > 1) {
        students = state.values.students
            .where((pStudent) => pStudent.id != studentId)
            .toList();
      }
      emit(StudentSuccess(state.values.copyWith(students: students)));
    } else {
      emit(StudentSuccess(
        state.values.copyWith(errorMessage: 'The api return error'),
      ));
    }
  }

  void changeValue(String value) {
    emit(StudentChangeValue(state.values.copyWith(currentValue: value)));
    print(state.values.currentValue.toString());
  }
}
