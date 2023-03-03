import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ExamYearSelector extends StatelessWidget {
  static List<int> yearDigits = [2, 0, 0, 0];
  const ExamYearSelector({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          ' Select year',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(34),
            fontWeight: FontWeight.bold,
            color: kTextLightColor.withOpacity(.8),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(20)),
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(20)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                getProportionateScreenWidth(30),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                YearSelector(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class YearSelector extends StatefulWidget {
  const YearSelector({
    Key key,
  }) : super(key: key);

  @override
  _YearSelectorState createState() => _YearSelectorState();
}

class _YearSelectorState extends State<YearSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(200),
      width: SizeConfig.screenWidth - getProportionateScreenWidth(80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DigitSelector(
            digit: ExamYearSelector.yearDigits[0],
            minus: () {
              if (ExamYearSelector.yearDigits[0] == 2) {
                setState(() {
                  ExamYearSelector.yearDigits[0]--;
                  ExamYearSelector.yearDigits[1] = 9;
                  ExamYearSelector.yearDigits[2] = 9;
                });
              }
            },
            plus: () {
              if (ExamYearSelector.yearDigits[0] == 1) {
                setState(() {
                  ExamYearSelector.yearDigits[0]++;
                  ExamYearSelector.yearDigits[1] = 0;
                  ExamYearSelector.yearDigits[2] = 0;
                });
              }
            },
          ),
          DigitSelector(
            digit: ExamYearSelector.yearDigits[1],
            minus: () {
              setState(() {
                ExamYearSelector.yearDigits[1] == 0
                    ? ExamYearSelector.yearDigits[1] = 9
                    : ExamYearSelector.yearDigits[1] = 0;
                if (ExamYearSelector.yearDigits[1] == 9) {
                  ExamYearSelector.yearDigits[0] = 1;
                  ExamYearSelector.yearDigits[2] = 9;
                } else {
                  ExamYearSelector.yearDigits[0] = 2;
                  ExamYearSelector.yearDigits[2] = 0;
                }
              });
            },
            plus: () {
              setState(() {
                ExamYearSelector.yearDigits[1] == 0
                    ? ExamYearSelector.yearDigits[1] = 9
                    : ExamYearSelector.yearDigits[1] = 0;
                if (ExamYearSelector.yearDigits[1] > 0) {
                  ExamYearSelector.yearDigits[0] = 1;
                  ExamYearSelector.yearDigits[2] = 9;
                } else {
                  ExamYearSelector.yearDigits[0] = 2;
                  ExamYearSelector.yearDigits[2] = 0;
                }
              });
            },
          ),
          DigitSelector(
            digit: ExamYearSelector.yearDigits[2],
            minus: () {
              if (ExamYearSelector.yearDigits[2] == 9) {
                setState(() {
                  ExamYearSelector.yearDigits[2] = 1;
                  ExamYearSelector.yearDigits[0] = 2;
                  ExamYearSelector.yearDigits[1] = 0;
                  if (ExamYearSelector.yearDigits[3] > 2) {
                    ExamYearSelector.yearDigits[3] = 2;
                  }
                });
              } else {
                setState(() {
                  ExamYearSelector.yearDigits[2] = 0;
                  ExamYearSelector.yearDigits[0] = 2;
                  ExamYearSelector.yearDigits[1] = 0;
                });
              }
            },
            plus: () {
              if (ExamYearSelector.yearDigits[2] == 0) {
                setState(() {
                  ExamYearSelector.yearDigits[2] = 1;
                  if (ExamYearSelector.yearDigits[3] > 2) {
                    ExamYearSelector.yearDigits[3] = 2;
                  }
                });
              } else {
                setState(() {
                  ExamYearSelector.yearDigits[2] = 9;
                  ExamYearSelector.yearDigits[0] = 1;
                  ExamYearSelector.yearDigits[1] = 9;
                });
              }
            },
          ),
          DigitSelector(
            digit: ExamYearSelector.yearDigits[3],
            plus: () {
              if (ExamYearSelector.yearDigits[3] < 9) {
                setState(() {
                  ExamYearSelector.yearDigits[3]++;
                  if (ExamYearSelector.yearDigits[3] > 2 &&
                      ExamYearSelector.yearDigits[2] == 1) {
                    ExamYearSelector.yearDigits[0] = 1;
                    ExamYearSelector.yearDigits[1] = 9;
                    ExamYearSelector.yearDigits[2] = 9;
                  }
                });
              }
            },
            minus: () {
              if (ExamYearSelector.yearDigits[3] > 0) {
                setState(() {
                  ExamYearSelector.yearDigits[3]--;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

class DigitSelector extends StatelessWidget {
  const DigitSelector({
    Key key,
    @required this.plus,
    @required this.minus,
    @required this.digit,
  }) : super(key: key);
  final GestureTapCallback plus, minus;
  final int digit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          getProportionateScreenWidth(20),
        ),
        color: Colors.white,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AddorMinusButton(
            sign: '+',
            onPress: plus,
          ),
          NumberDisplay(digit: digit),
          AddorMinusButton(
            sign: '-',
            onPress: minus,
          ),
        ],
      ),
    );
  }
}

class NumberDisplay extends StatelessWidget {
  const NumberDisplay({
    Key key,
    @required this.digit,
  }) : super(key: key);
  final int digit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(60),
      width: getProportionateScreenWidth(60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          getProportionateScreenWidth(20),
        ),
      ),
      child: Center(
        child: Text(
          '$digit',
          style: TextStyle(
            color: kTextColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class AddorMinusButton extends StatelessWidget {
  const AddorMinusButton({
    Key key,
    @required this.sign,
    @required this.onPress,
  }) : super(key: key);
  final String sign;
  final GestureTapCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(60),
      width: getProportionateScreenWidth(60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          getProportionateScreenWidth(20),
        ),
        color: kBackgroundColor,
        // boxShadow: [
        //   BoxShadow(
        //     offset: Offset(4, 4),
        //     color: kLightColor.withOpacity(.6),
        //     blurRadius: 6,
        //     spreadRadius: 1,
        //   ),
        // ],
      ),
      child: FlatButton(
        splashColor: kAppBarColor.withOpacity(.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(20),
          ),
        ),
        onPressed: onPress,
        child: Center(
          child: Text(
            sign,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
