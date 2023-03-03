import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    @required this.title,
    @required this.onPress,
    this.padding = 0,
    this.color = kButtonColor,
  }) : super(key: key);
  final String title;
  final GestureTapCallback onPress;
  final double padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(padding),
      ),
      child: InkWell(
        splashColor: color,
        highlightColor: Colors.transparent,
        onTap: onPress,
        borderRadius: BorderRadius.circular(
          getProportionateScreenWidth(26),
        ),
        child: Ink(
          color: color,
          child: Container(
            height: getProportionateScreenHeight(60),
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                getProportionateScreenWidth(26),
              ),
              color: color,
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(20),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
