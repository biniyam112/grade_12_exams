import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key key,
    this.onChanged,
  }) : super(key: key);

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: SizeConfig.screenWidth - getProportionateScreenWidth(40),
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),
      decoration: BoxDecoration(
        border: Border.all(
          color: kAppBarColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(
          getProportionateScreenWidth(16),
        ),
      ),
      child: TextField(
        autocorrect: true,
        cursorColor: kTextColor,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 17,
          color: kTextColor,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          suffix: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(30),
            splashColor: kButtonSplashColor,
            child: Container(
              child: SvgPicture.asset(
                'assets/icons/search.svg',
                color: kAppBarColor,
              ),
            ),
          ),
          hintText: 'Search',
          hintStyle: TextStyle(color: kTextMediumColor),
        ),
      ),
    );
  }
}
