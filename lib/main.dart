import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade_12_exams/models/rate_app.dart';
import 'package:grade_12_exams/screens/home/home_screen.dart';
import 'package:grade_12_exams/screens/support_us/support_us.dart';
import 'package:rate_my_app/rate_my_app.dart';

import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RateMyAppBuilder(
      builder: (context) {
        return MaterialApp(
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            SupportUsScreen.routeName: (context) => SupportUsScreen(),
          },
          title: 'Grade 12 exam',
          debugShowCheckedModeBanner: false,
          color: kAppBarColor,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              centerTitle: true,
              color: kAppBarColor,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.white,
                size: 10,
              ),
              textTheme: TextTheme(
                headline6: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            scaffoldBackgroundColor: Colors.white,
            fontFamily: GoogleFonts.poppins().fontFamily,
            primaryColor: kPrimaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.poppinsTextTheme().apply(
              displayColor: kTextColor,
            ),
          ),
          home: HomeScreen(),
        );
      },
      rateMyApp: rateMyApp,
      onInitialized: (context, ratemyapp) {
        print('im initializaed motherfucker!');
      },
    );
  }
}
