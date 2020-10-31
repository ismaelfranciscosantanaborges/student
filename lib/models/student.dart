class Student {
  final String id;
  final String firstName;
  final String lastName;
  final String career;
  final bool status;

  Student({this.id, this.firstName, this.career, this.lastName, this.status});

  Student copyWith({
    int id,
    String firstName,
    String career,
    String lastName,
    bool status,
  }) {
    return Student(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        career: career ?? this.career,
        status: status ?? this.status);
  }

  factory Student.fromMap(Map<String, dynamic> json) => Student(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        career: json['career'],
        status: json['status'] == "1",
      );

  Map<String, dynamic> toMap() => {
        'first_name': this.firstName,
        'last_name': this.lastName,
        'career': this.career,
        'status': this.status ? 1 : 0,
      };
}
