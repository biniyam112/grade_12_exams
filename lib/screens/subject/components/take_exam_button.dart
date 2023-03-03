import 'package:flutter/material.dart';
import 'package:grade_12_exams/constants.dart';

import '../../../size_config.dart';

class TakeExamButton extends StatelessWidget {
  const TakeExamButton({
    Key key,
    @required this.onPress,
  }) : super(key: key);
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(32),
      ),
      child: InkWell(
        highlightColor: kButtonColor.withOpacity(.8),
        splashColor: kButtonSplashColor,
        borderRadius: BorderRadius.circular(
          getProportionateScreenWidth(20),
        ),
        onTap: onPress,
        child: Ink(
          decoration: BoxDecoration(
            color: kButtonColor.withOpacity(.8),
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(20),
            ),
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenWidth(16),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                getProportionateScreenWidth(20),
              ),
            ),
            child: Center(
              child: Text(
                'Take exam',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: getProportionateScreenWidth(22),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
