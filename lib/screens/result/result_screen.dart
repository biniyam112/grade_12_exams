import 'package:flutter/material.dart';
import 'package:grade_12_exams/screens/result/components/body.dart';
import 'package:grade_12_exams/size_config.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    Key key,
    @required this.grade,
    @required this.outOf,
  }) : super(key: key);
  final int grade, outOf;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(grade: grade, outOf: outOf),
    );
  }
}
