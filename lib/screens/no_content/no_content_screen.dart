import 'package:flutter/material.dart';

import '../../size_config.dart';

class NoContentScreen extends StatelessWidget {
  const NoContentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'no content'.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Image.asset(
                'assets/gifs/no_content.gif',
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'Coming soon!'.toUpperCase(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
