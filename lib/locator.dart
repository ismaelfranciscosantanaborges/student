import 'package:get_it/get_it.dart';
import 'package:students_register/blocs/cubit/students_cubit.dart';
import 'package:students_register/repositories/student_api_client.dart';

void setup() {
  final studentApiClient = StudentApiClient();
  locator.registerLazySingleton(() => StudentCubit(studentApiClient));
}

final locator = GetIt.instance;
