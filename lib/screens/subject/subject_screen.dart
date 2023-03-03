import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade_12_exams/models/values.dart';

import 'components/body.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({
    Key key,
    @required this.subject,
  }) : super(key: key);
  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          subject.title,
          style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Body(
        subject: subject,
      ),
    );
  }
}
