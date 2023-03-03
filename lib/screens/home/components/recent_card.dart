import 'package:flutter/material.dart';
import 'package:grade_12_exams/models/save_recent_exam.dart';
import 'package:grade_12_exams/models/values.dart';
import 'package:grade_12_exams/screens/exam/exam_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class RecentCard extends StatelessWidget {
  const RecentCard({
    Key key,
    @required this.recentExamState,
  }) : super(key: key);

  final RecentExamState recentExamState;

  @override
  Widget build(BuildContext context) {
    toTimeOfDay(List<String> remainingTime) {
      return TimeOfDay(
        hour: int.parse(remainingTime[0]),
        minute: int.parse(remainingTime[1]),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenHeight(10),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(4, 4),
              color: kLightColor.withOpacity(.6),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(20),
          ),
        ),
        child: FutureBuilder(
            future: getRecentExamState(),
            builder: (context, snapshot) {
              return examState.title == null
                  ? Wrap(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(20),
                            ),
                            child: Text(
                              'There is no recent exam!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        VerticalSpacing(of: 16),
                        Text(
                          'Recent Exam',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                        VerticalSpacing(of: getProportionateScreenHeight(10)),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: kTextColor,
                            ),
                            children: [
                              TextSpan(
                                text: recentExamState.title,
                              ),
                              TextSpan(
                                text: ' - ',
                              ),
                              TextSpan(
                                text: '${recentExamState.year}',
                              ),
                            ],
                          ),
                        ),
                        VerticalSpacing(of: getProportionateScreenHeight(10)),
                        VerticalSpacing(of: getProportionateScreenHeight(10)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: SizeConfig.screenWidth -
                                    getProportionateScreenHeight(180),
                                height: getProportionateScreenHeight(20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(20)),
                                  child: LinearProgressIndicator(
                                    backgroundColor:
                                        kLightColor.withOpacity(.6),
                                    valueColor:
                                        AlwaysStoppedAnimation(kprogressColor),
                                    value: recentExamState.percentile != null
                                        ? recentExamState.percentile.isFinite
                                            ? recentExamState.percentile / 100
                                            : 0
                                        : 0,
                                  ),
                                ),
                              ),
                              SizedBox(width: getProportionateScreenWidth(16)),
                              Text(
                                recentExamState.percentile != null
                                    ? recentExamState.percentile.isFinite
                                        ? '${recentExamState.percentile.toInt()} %'
                                        : '0 %'
                                    : '0 %',
                                style: TextStyle(
                                  color: kAppBarColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(16),
                              horizontal: getProportionateScreenHeight(100)),
                          child: RecentCardButton(
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return ExamScreen(
                                    year: examState.year,
                                    subject: Subject(
                                      title: examState.title,
                                    ),
                                    examTime:
                                        toTimeOfDay(examState.remainingTime),
                                    answersFromRecent: examState.answers,
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                      ],
                    );
            }),
      ),
    );
  }
}

class RecentCardButton extends StatelessWidget {
  const RecentCardButton({
    Key key,
    @required this.onPress,
  }) : super(key: key);

  final GestureTapCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      splashColor: kButtonSplashColor,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(12),
          horizontal: getProportionateScreenHeight(20),
        ),
        decoration: BoxDecoration(
          color: kButtonColor.withOpacity(.8),
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(20),
          ),
        ),
        child: Center(
          child: Text(
            'Continue',
            style: TextStyle(
              color: Colors.white,
              fontSize: getProportionateScreenWidth(20),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
