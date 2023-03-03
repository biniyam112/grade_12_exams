import 'package:flutter/material.dart';
import 'package:grade_12_exams/constants.dart';
import 'package:grade_12_exams/size_config.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
    @required this.grade,
    @required this.outOf,
  }) : super(key: key);
  final int grade, outOf;

  gradeRange() {
    int percentile = ((grade / outOf) * 100).toInt();
    if (percentile == 100) {
      return 0;
    } else if (percentile >= 80) {
      return 1;
    } else if (percentile >= 60) {
      return 2;
    } else if (percentile >= 40) {
      return 3;
    } else {
      return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> imagePath = [
      'assets/images/trophy.png',
      'assets/images/trophy.png',
      'assets/images/thumbs_up.png',
      'assets/images/neutral.png',
      'assets/images/disappointed.png'
    ];
    List<String> remark = [
      'Perfect',
      'Impressive',
      'Not bad',
      'Needs some work',
      'Disappointed'
    ];
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: SizeConfig.screenHeight / 1.5,
              width: SizeConfig.screenWidth - getProportionateScreenWidth(80),
              decoration: BoxDecoration(
                color: Color(0xFF453834),
                borderRadius: BorderRadius.circular(
                  getProportionateScreenWidth(40),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(-4, 8),
                    color: kLightColor.withOpacity(.6),
                    blurRadius: 10,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  VerticalSpacing(of: 20),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Result',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(30),
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  VerticalSpacing(of: 10),
                  Text(
                    '$grade / $outOf',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  VerticalSpacing(of: 20),
                  Container(
                    padding: EdgeInsets.all(getProportionateScreenHeight(40)),
                    height: getProportionateScreenWidth(200),
                    width: getProportionateScreenWidth(200),
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(-6, 4),
                          color: kTextLightColor.withOpacity(.6),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          offset: Offset(4, -3),
                          color: kTextLightColor.withOpacity(.6),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      imagePath[gradeRange()],
                    ),
                  ),
                  VerticalSpacing(of: 20),
                  Text(
                    remark[gradeRange()],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: getProportionateScreenWidth(22),
                    ),
                  ),
                  VerticalSpacing(of: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                    child: Text(
                      'Lorem Ipsum is  release versions of Lorem Ipsum.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.4,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              borderRadius: BorderRadius.circular(
                getProportionateScreenWidth(30),
              ),
              splashColor: kButtonSplashColor,
              highlightColor: kButtonSplashColor.withOpacity(.5),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(30),
                  ),
                  color: kButtonColor,
                ),
                child: Container(
                  height: getProportionateScreenHeight(70),
                  width:
                      SizeConfig.screenWidth - getProportionateScreenWidth(60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenWidth(30),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Take another exam',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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
