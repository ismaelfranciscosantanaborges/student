class ApiResponse<T> {
  final T data;
  final int status;

  ApiResponse({this.data, this.status});
}
