import 'package:flutter/material.dart';
import 'package:grade_12_exams/models/save_recent_exam.dart';
import 'package:grade_12_exams/models/values.dart';
import 'package:grade_12_exams/size_config.dart';

import 'exam_card_category_selector.dart';
import 'exam_subjects_list.dart';
import 'recent_card.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int activeCategoryIndex = 0;
  void updateCategory() {
    setState(() {
      activeCategoryIndex = ExamCardCategorySelector.activeCategoryIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            VerticalSpacing(of: getProportionateScreenHeight(10)),
            RecentCard(
              recentExamState: examState,
            ),
            VerticalSpacing(of: getProportionateScreenHeight(20)),
            ExamCardCategorySelector(
              onPress: updateCategory,
            ),
            VerticalSpacing(of: getProportionateScreenHeight(10)),
            ExamSubjectsList(
              department: departments[activeCategoryIndex],
            ),
            VerticalSpacing(of: getProportionateScreenHeight(20)),
          ],
        ),
      ),
    );
  }
}
