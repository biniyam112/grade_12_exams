import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SubmitExamButton extends StatelessWidget {
  const SubmitExamButton({
    Key key,
    this.text = 'Submit answer',
    @required this.onPress,
  }) : super(key: key);

  final String text;
  final GestureTapCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.red,
      highlightColor: Colors.transparent,
      onTap: onPress,
      borderRadius: BorderRadius.circular(
        getProportionateScreenWidth(26),
      ),
      child: Container(
        height: getProportionateScreenHeight(60),
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(26),
          ),
          color: kButtonColor,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(20),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
