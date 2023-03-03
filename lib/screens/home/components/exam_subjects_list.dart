import 'package:flutter/material.dart';
import 'package:grade_12_exams/models/values.dart';

import '../../../size_config.dart';
import 'subject_exam_card.dart';

class ExamSubjectsList extends StatefulWidget {
  const ExamSubjectsList({
    Key key,
    @required this.department,
  }) : super(key: key);
  final String department;

  @override
  ExamSubjectsListState createState() => ExamSubjectsListState();
}

class ExamSubjectsListState extends State<ExamSubjectsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          itemBuilder: (context, index) {
            return SubjectExamCard(
              subject: subjectByDepartment(widget.department)[index],
            );
          },
          itemCount: subjectByDepartment(widget.department).length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: getProportionateScreenWidth(12),
            mainAxisSpacing: getProportionateScreenWidth(12),
          ),
        ),
      ],
    );
  }
}
