import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grade_12_exams/components/default_button.dart';
import 'package:grade_12_exams/models/values.dart';
import 'package:grade_12_exams/size_config.dart';
import 'package:ussd/ussd.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...List.generate(donationLevels.length, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10),
                ),
                child: DonationCard(
                  donationLevelTitle: donationLevels[index].title,
                  amount: donationLevels[index].amount,
                  donationLevelColor: donationLevels[index].color,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class DonationCard extends StatelessWidget {
  const DonationCard({
    Key key,
    @required this.amount,
    @required this.donationLevelColor,
    @required this.donationLevelTitle,
  }) : super(key: key);
  final String donationLevelTitle;
  final int amount;
  final Color donationLevelColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Container(
        height: getProportionateScreenHeight(200),
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          // color: Colors.white,
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(20),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  child: SvgPicture.asset(
                    'assets/icons/medal.svg',
                    color: donationLevelColor,
                  ),
                ),
                Text(
                  '$donationLevelTitle level donation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            DefaultButton(
              title: '$amount Birr',
              padding: 40,
              color: donationLevelColor,
              onPress: () {
                _transferMoneyUSSDrequest(amount);
              },
            ),
          ],
        ),
      ),
    );
  }

  _transferMoneyUSSDrequest(int amount) async {
    String phone = '0941726567';
    try {
      String response = await Ussd.runUssd('*806*$phone*$amount#');
      print(response);
    } catch (e) {
      print('the error is : $e');
    }
  }
}
