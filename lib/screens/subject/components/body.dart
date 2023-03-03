import 'package:flutter/material.dart';
import 'package:grade_12_exams/constants.dart';
import 'package:grade_12_exams/models/values.dart';
import 'package:grade_12_exams/screens/exam/exam_screen.dart';

import '../../../size_config.dart';
import 'exam_year_selector.dart';
import 'take_exam_button.dart';

class Body extends StatelessWidget {
  Body({
    Key key,
    @required this.subject,
  }) : super(key: key);
  final Subject subject;

  static int hour = 0;
  static int minute = 0;

  @override
  Widget build(BuildContext context) {
    FixedExtentScrollController hourController =
        new FixedExtentScrollController();
    FixedExtentScrollController minuteController =
        new FixedExtentScrollController();
    void setTimeToDefault() async {
      hour = (subject.examTime / 60).floor();
      minute = (subject.examTime % 60);
      print('$hour \nand the other\n $minute');
      await hourController.animateTo(
        (hour * 80).toDouble(),
        duration: Duration(seconds: 1),
        curve: Curves.elasticIn,
      );
      await minuteController.animateTo(
        (minute * 80).toDouble(),
        duration: Duration(seconds: 1),
        curve: Curves.elasticInOut,
      );
    }

    void toExamPage() {
      if (hour == 0 && minute == 0) {
        hour = (subject.examTime / 60).floor();
        minute = (subject.examTime % 60);
      }
      print('with $hour hour and $minute minute');
      int year = int.parse(ExamYearSelector.yearDigits.join());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ExamScreen(
              subject: subject,
              year: year,
              examTime: TimeOfDay(
                hour: hour.toInt(),
                minute: minute.toInt(),
              ),
            );
          },
        ),
      );
    }

    return SizedBox(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VerticalSpacing(of: getProportionateScreenHeight(20)),
              TimeOptions(
                setTimeToDefault: setTimeToDefault,
                hourController: hourController,
                minuteController: minuteController,
              ),
              VerticalSpacing(of: getProportionateScreenHeight(20)),
              ExamYearSelector(),
              VerticalSpacing(of: getProportionateScreenHeight(20)),
              TakeExamButton(
                onPress: toExamPage,
              ),
              VerticalSpacing(of: getProportionateScreenHeight(20)),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeOptions extends StatelessWidget {
  const TimeOptions({
    Key key,
    @required this.setTimeToDefault,
    @required this.hourController,
    @required this.minuteController,
  }) : super(key: key);
  final GestureTapCallback setTimeToDefault;
  final FixedExtentScrollController hourController, minuteController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        getProportionateScreenWidth(20),
      ),
      child: Container(
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.all(
          getProportionateScreenWidth(20),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(8),
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
          children: [
            Text(
              'Use Custom time',
              style: TextStyle(
                fontSize: getProportionateScreenWidth(34),
                fontWeight: FontWeight.bold,
                color: kTextLightColor.withOpacity(.8),
              ),
            ),
            VerticalSpacing(of: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // the hour wheel
                TimeSelectorWheel(
                  onChanged: (value) => Body.hour = value,
                  wheelMaxNumber: 4,
                  scrollController: hourController,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: getProportionateScreenHeight(10),
                    right: getProportionateScreenWidth(20),
                  ),
                  child: Text(
                    'Hour/s',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kTextColor.withOpacity(.7),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: getProportionateScreenHeight(30),
                  ),
                  child: Text(
                    ':',
                    style: TextStyle(fontSize: 38),
                  ),
                ),
                //the minute wheel
                TimeSelectorWheel(
                  onChanged: (value) => Body.minute = value,
                  wheelMaxNumber: 60,
                  scrollController: minuteController,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: getProportionateScreenHeight(10),
                    right: getProportionateScreenWidth(20),
                  ),
                  child: Text(
                    'Minute/s',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kTextColor.withOpacity(.7),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(8),
                  horizontal: getProportionateScreenWidth(60),
                ),
                child: InkWell(
                  onTap: setTimeToDefault,
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(20),
                  ),
                  splashColor: kButtonSplashColor,
                  highlightColor: kButtonColor.withOpacity(.8),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(20),
                      ),
                      color: kButtonColor.withOpacity(.8),
                    ),
                    child: Container(
                      width: SizeConfig.screenWidth,
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(20),
                      ),
                      decoration: BoxDecoration(
                        color: kButtonColor.withOpacity(.8),
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(20),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Use Default Time',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeSelectorWheel extends StatelessWidget {
  const TimeSelectorWheel({
    Key key,
    @required this.scrollController,
    @required this.wheelMaxNumber,
    @required this.onChanged,
  }) : super(key: key);
  final FixedExtentScrollController scrollController;
  final int wheelMaxNumber;
  final Function(int value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(220),
      width: SizeConfig.screenWidth / 5,
      child: ListWheelScrollView(
        controller: scrollController,
        diameterRatio: 100,
        squeeze: 1.1,
        itemExtent: 80,
        overAndUnderCenterOpacity: .4,
        physics: FixedExtentScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        onSelectedItemChanged: onChanged,
        children: [
          ...List.generate(wheelMaxNumber, (index) {
            return Text(
              index.toString().padLeft(2, '0'),
              style: TextStyle(
                color: kTextLightColor,
                fontSize: 38,
                letterSpacing: 1.5,
              ),
            );
          }),
        ],
      ),
    );
  }
}
