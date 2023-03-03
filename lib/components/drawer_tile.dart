import 'package:flutter/material.dart';
import 'package:grade_12_exams/constants.dart';
import 'package:grade_12_exams/size_config.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  final bool isSelected;
  final Color iconColor;

  DrawerTile(
      {this.title,
      this.icon,
      this.onTap,
      this.isSelected = false,
      this.iconColor = kTextMediumColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: isSelected ? kButtonColor : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          children: [
            Icon(icon, size: 22, color: isSelected ? Colors.white : iconColor),
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(12),
              ),
              child: Text(
                title,
                style: TextStyle(
                  letterSpacing: .3,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : null,
                  color:
                      isSelected ? Colors.white : Color.fromRGBO(0, 0, 0, .8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
