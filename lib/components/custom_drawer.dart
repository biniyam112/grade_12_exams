import 'package:flutter/material.dart';
import 'package:grade_12_exams/models/rate_app.dart';
import 'package:grade_12_exams/screens/Settings/settings_screen.dart';
import 'package:grade_12_exams/screens/about_us/about_us.dart';
import 'package:grade_12_exams/screens/home/home_screen.dart';
import 'package:grade_12_exams/screens/support_us/support_us.dart';
import 'package:grade_12_exams/size_config.dart';
import 'package:rate_my_app/rate_my_app.dart';

import 'drawer_tile.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key key,
  }) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => refresh());
  }

  static String currentPage = '/home';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth / 1.4,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth / 1.4,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: getProportionateScreenWidth(20),
                      left: getProportionateScreenWidth(12),
                      right: getProportionateScreenWidth(12),
                    ),
                    children: [
                      DrawerTile(
                        icon: Icons.home,
                        onTap: () {
                          if (currentPage != "/home") {
                            setState(() {
                              currentPage = '/home';
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ));
                            });
                          }
                        },
                        iconColor: Colors.deepPurple[400],
                        title: "Home",
                        isSelected: currentPage == "/home" ? true : false,
                      ),
                      DrawerTile(
                        icon: Icons.leaderboard_outlined,
                        onTap: () {
                          setState(() {
                            currentPage = '/leader';
                          });
                        },
                        iconColor: Colors.orange[800],
                        title: 'Leader Board',
                        isSelected: currentPage == "/leader" ? true : false,
                      ),
                      DrawerTile(
                        icon: Icons.verified,
                        onTap: () {
                          setState(() {
                            currentPage = '/premium';
                          });
                        },
                        iconColor: Colors.tealAccent[700],
                        title: 'Buy Premium',
                        isSelected: currentPage == "/premium" ? true : false,
                      ),
                      DrawerTile(
                        icon: Icons.settings,
                        onTap: () {
                          setState(() {
                            currentPage = '/settings';
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return SettingsScreen();
                              },
                            ));
                          });
                        },
                        iconColor: Colors.blue,
                        title: 'Settings',
                        isSelected: currentPage == "/settings" ? true : false,
                      ),
                    ],
                  ),
                ),
                Divider(height: 4, thickness: 0.3, color: Colors.black87),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(8),
                        right: getProportionateScreenWidth(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DrawerTile(
                          title: 'Support us',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SupportUsScreen();
                                },
                              ),
                            );
                          },
                        ),
                        DrawerTile(
                          title: 'About us',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AboutUsScreen();
                                },
                              ),
                            );
                          },
                        ),
                        DrawerTile(
                          title: 'Rate app',
                          onTap: rateApp,
                        ),
                        DrawerTile(
                          title: 'Check update',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DebuggableCondition> debuggableConditions = [];
  bool shouldOpenDialog = false;
  String message =
      'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.';
  Color messageColor = Colors.black;

  void rateApp() async {
    await rateMyApp.showStarRateDialog(
      context,
      starRatingOptions: StarRatingOptions(
        initialRating: 0,
        starsBorderColor: Colors.black,
      ),
      actionsBuilder: (_, stars) {
        switch (stars.round()) {
          case 1:
            message = 'You hate this app?';
            messageColor = Colors.deepOrange[700];
            break;
          case 2:
            message = 'Appreciatable';
            messageColor = Colors.orange[800];
            break;
          case 3:
            message = 'Well, this\'s average.';
            messageColor = Colors.yellow[700];
            break;
          case 4:
            message = 'So you like this app heh!';
            messageColor = Colors.lime[800];
            break;
          case 5:
            message = 'Great ! <3';
            messageColor = Colors.green[700];
            break;
        }
        return rateAppWithStars(context, stars);
      },
      onDismissed: () {
        rateMyApp.callEvent(RateMyAppEventType.noButtonPressed);
        rateMyApp.reset();
      },
      message: message,
      dialogStyle: DialogStyle(
        messageStyle: TextStyle(color: messageColor),
      ),
    );
  }

  List<Widget> rateAppWithStars(BuildContext context, double stars) {
    final Widget cancelButton = RateMyAppNoButton(
      rateMyApp,
      text: MaterialLocalizations.of(context).cancelButtonLabel.toUpperCase(),
      callback: () {
        refresh();
      },
    );
    final Widget rateButton = RateMyAppRateButton(
      rateMyApp,
      text: 'Rate app',
      callback: () {
        refresh();
      },
    );
    final Widget laterButton = RateMyAppLaterButton(
      rateMyApp,
      text: 'Maybe later',
      callback: () {
        refresh();
      },
    );
    if (stars == 0 || stars == null) {
      return [cancelButton];
    }
    return [
      rateButton,
      laterButton,
      cancelButton,
    ];
  }

  void refresh() {
    setState(() {
      debuggableConditions =
          rateMyApp.conditions.whereType<DebuggableCondition>().toList();
      shouldOpenDialog = rateMyApp.shouldOpenDialog;
    });
  }
}
