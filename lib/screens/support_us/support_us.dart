import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade_12_exams/constants.dart';
import 'package:grade_12_exams/size_config.dart';

import 'components/body.dart';

class SupportUsScreen extends StatelessWidget {
  const SupportUsScreen({Key key}) : super(key: key);
  static String routeName = '/support_us';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        centerTitle: true,
        title: Text(
          'Donation',
          style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            // size: 24,
          ),
        ),
      ),
      body: Body(),
    );
  }
}
