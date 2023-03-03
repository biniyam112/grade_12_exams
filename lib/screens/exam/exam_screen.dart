import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade_12_exams/constants.dart';
import 'package:grade_12_exams/models/save_recent_exam.dart';
import 'package:grade_12_exams/models/values.dart';
import 'package:grade_12_exams/screens/home/home_screen.dart';
import 'package:grade_12_exams/size_config.dart';

import 'components/body.dart';

class ExamScreen extends StatelessWidget {
  const ExamScreen({
    Key key,
    @required this.year,
    @required this.subject,
    this.answersFromRecent,
    this.examTime,
  }) : super(key: key);
  final int year;
  final Subject subject;
  final List<String> answersFromRecent;
  final TimeOfDay examTime;

  static List<int> currentAnswers = [];
  static TimeOfDay remainingTime = TimeOfDay(hour: 0, minute: 0);
  static bool readyToEvaluate = false;

  void storeExamState() {
    double totalQuestions = currentAnswers.length.toDouble();
    double answeredQuestions = currentAnswers.length.toDouble();
    currentAnswers.forEach((element) {
      if (element == null) {
        answeredQuestions--;
      }
    });
    double percentile = (answeredQuestions / totalQuestions) * 100;

    saveExamState(
      examState: RecentExamState(
        answers: currentAnswers.map((e) {
          if (e != null) {
            return e.toString();
          } else {
            return null;
          }
        }).toList(),
        title: subject.title,
        year: year,
        percentile: percentile,
        remainingTime: [
          remainingTime.hour.toString(),
          remainingTime.minute.toString(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            if (readyToEvaluate == true) {
              Navigator.popUntil(context, (route) => route.isFirst);
              return null;
            }
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Save and Exit?'),
                  content: Text('are you sure you want to save and exit?'),
                  actions: [
                    FlatButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('No'),
                    ),
                    FlatButton(
                      onPressed: () {
                        storeExamState();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ));
                      },
                      child: Text('Yes'),
                    ),
                  ],
                );
              },
            );
          },
        ),
        elevation: 0,
        backgroundColor: kAppBarColor,
        centerTitle: true,
        title: Text(
          subject.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.poppins().fontFamily,
            color: Colors.white,
          ),
        ),
      ),
      body: Body(
        subject: subject,
        year: year,
        answersFromRecent: answersFromRecent,
        examTime: examTime,
      ),
      // ),
    );
  }
}
