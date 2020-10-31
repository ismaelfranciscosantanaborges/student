import 'package:flutter/material.dart';
import 'package:students_register/blocs/cubits.dart';
import 'package:students_register/locator.dart';
import 'package:students_register/models/models.dart';
import 'package:students_register/pages/pages.dart';
import 'package:students_register/widgets/widgets.dart';

class CSearchDelegate extends SearchDelegate {
  CSearchDelegate(this.listStudents);

  final List<Student> listStudents;
  String selectedResult;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Student> suggestionList = [];
    query.isEmpty
        ? suggestionList = listStudents
            .where((element) => element.career.contains('Softwa'))
            .toList()
        : suggestionList.addAll(
            listStudents.where(
              (element) => element.career.contains(query),
            ),
          );
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return CListTile(
          student: suggestionList[index],
          index: index,
          onPress: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddAndUpdateStuden(
                  student: suggestionList[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
