part of 'students_cubit.dart';

class StudentValues {
  StudentValues({this.students, this.errorMessage, this.currentValue});

  final List<Student> students;
  final String errorMessage;
  final String currentValue;

  StudentValues copyWith(
      {List<Student> students, String errorMessage, String currentValue}) {
    return StudentValues(
      students: students ?? this.students,
      errorMessage: errorMessage,
      currentValue: currentValue ?? this.currentValue,
    );
  }
}

abstract class StudentState extends Equatable {
  const StudentState(this.values);

  final StudentValues values;

  @override
  List<Object> get props => [values];
}

class StudentsInitial extends StudentState {
  StudentsInitial(StudentValues values) : super(values);
}

class StudentSuccess extends StudentState {
  StudentSuccess(StudentValues values) : super(values);
}

class StudentLoading extends StudentState {
  StudentLoading(StudentValues values) : super(values);
}

class StudentError extends StudentState {
  StudentError(StudentValues values) : super(values);
}

class StudentChangeValue extends StudentState {
  StudentChangeValue(StudentValues values) : super(values);
}
