import 'package:flutter/material.dart';
import 'package:grade_12_exams/constants.dart';
import 'package:grade_12_exams/models/values.dart';
import 'package:grade_12_exams/screens/subject/subject_screen.dart';

import '../../../size_config.dart';

class SubjectExamCard extends StatelessWidget {
  const SubjectExamCard({
    Key key,
    @required this.subject,
  }) : super(key: key);
  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return SubjectScreen(
              subject: subject,
            );
          },
        ));
      },
      splashColor: kPrimaryColor.withOpacity(.3),
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(
        getProportionateScreenWidth(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(20),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(4, 4),
              color: kLightColor.withOpacity(.6),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(flex: 2),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(16)),
              child: Text(
                subject.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                subject.imagePath,
                height: getProportionateScreenWidth(80),
              ),
            ),
            Spacer(flex: 4),
          ],
        ),
      ),
    );
  }
}
