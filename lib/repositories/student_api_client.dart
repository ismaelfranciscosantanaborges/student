import 'dart:io';

import 'package:dio/dio.dart';
import 'package:students_register/repositories/api_response.dart';

import 'enviroment.dart';

class StudentApiClient with Enviroment {
  final _dio = Dio();
  Future<ApiResponse<List>> getStudents() async {
    Map<String, dynamic> _headers = {
      'Access-Control-Allow-Orign': 'http://localhost:54740',
      'Access-Control-Allow-Hearders': 'http://localhost:54740'
      // '':''
    };
    final response = await _dio.get(
      '$url/students.php',
      options: Options(
        headers: _headers,
      ),
    );

    List _data;
    if (response.statusCode == HttpStatus.ok) {
      _data = response.data;
    }

    return ApiResponse<List>(status: response.statusCode, data: _data);
  }

  Future<ApiResponse> postStudents(Map<String, dynamic> data) async {
    final response = await _dio.post('$url/students.php', data: data);

    Map _data;
    if (response.statusCode == HttpStatus.ok) {
      _data = response.data;
    }

    return ApiResponse<Map>(status: response.statusCode, data: _data);
  }

  Future<ApiResponse> putStudents(
      String studentId, Map<String, dynamic> data) async {
    final response =
        await _dio.put('$url/students.php?id=$studentId', data: data);

    Map _data;
    if (response.statusCode == HttpStatus.ok) {
      _data = response.data;
    }

    return ApiResponse<Map>(status: response.statusCode, data: _data);
  }

  Future<ApiResponse> deleteStudents(String studentId) async {
    final response = await _dio.delete('$url/students.php?id=$studentId');

    Map _data;
    if (response.statusCode == HttpStatus.ok) {
      _data = response.data;
    }

    return ApiResponse<Map>(status: response.statusCode, data: _data);
  }
}
