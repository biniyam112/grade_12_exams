import 'package:flutter/material.dart';
import 'package:grade_12_exams/constants.dart';
import 'package:grade_12_exams/models/values.dart';

import '../../../size_config.dart';

class ExamCardCategorySelector extends StatelessWidget {
  static int activeCategoryIndex = 0;
  final Function onPress;

  const ExamCardCategorySelector({
    Key key,
    @required this.onPress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...List.generate(departments.length, (index) {
            return Padding(
                padding: (index == 0)
                    ? EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20))
                    : EdgeInsets.only(
                        right: getProportionateScreenWidth(20),
                      ),
                child: InkWell(
                  onTap: () {
                    activeCategoryIndex = index;
                    onPress();
                  },
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(12),
                  ),
                  splashColor: kButtonColor,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(6),
                      horizontal: getProportionateScreenWidth(26),
                    ),
                    decoration: BoxDecoration(
                      color: (activeCategoryIndex == index)
                          ? kButtonColor
                          : kButtonSplashColor.withOpacity(.6),
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(12),
                      ),
                    ),
                    child: Text(
                      departments[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: getProportionateScreenWidth(16),
                      ),
                    ),
                  ),
                ));
          }),
        ],
      ),
    );
  }
}
