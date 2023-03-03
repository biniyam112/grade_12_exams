import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grade_12_exams/models/question_fetcher.dart';
import 'package:grade_12_exams/models/save_recent_exam.dart';
import 'package:grade_12_exams/models/values.dart';
import 'package:grade_12_exams/screens/exam/exam_screen.dart';
import 'package:grade_12_exams/screens/home/home_screen.dart';
import 'package:grade_12_exams/screens/no_content/no_content_screen.dart';
import 'package:grade_12_exams/screens/result/result_screen.dart';
import 'package:grade_12_exams/size_config.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  final int year;
  final Subject subject;
  final List<String> answersFromRecent;
  final TimeOfDay examTime;

  const Body({
    Key key,
    @required this.year,
    @required this.subject,
    this.answersFromRecent,
    @required this.examTime,
  }) : super(key: key);
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  bool evaluate = false;
  List<ChoiceQuestion> questions = [];
  String currentRoute = 'examScreen';
  List<int> selectedRadio = List<int>.filled(0, null, growable: true);
  Duration examDuration;
  TimeOfDay remainingTime;
  Timer _timer;
  Timer _noContentTimer;

  fetchdata(String data) {
    questions = fetchQuestion(data, widget.year.toString());
    // toNoContentScreen();
    // selectedRadio.length = questions.length;
    selectedRadio.length = 5;
  }

  startTimer() {
    if (remainingTime == null) {
      remainingTime = TimeOfDay(
        hour: widget.examTime.hour,
        minute: widget.examTime.minute,
      );
    }
    if (examDuration == null) {
      examDuration = Duration(
        hours: widget.examTime.hour,
        minutes: widget.examTime.minute,
      );
    }
    print(examDuration.inMinutes);
    if (examDuration.inMinutes == 0) {
      setState(() {
        evaluate = true;
        ExamScreen.readyToEvaluate = evaluate;
      });
    } else {
      _timer = Timer.periodic(Duration(seconds: 5), (timer) {
        if (examDuration.inMinutes - 1 <= 0) {
          setState(() {
            evaluate = true;
            ExamScreen.readyToEvaluate = evaluate;
          });
          _timer.cancel();
        }
        examDuration = Duration(
          minutes: (examDuration.inMinutes - 1),
        );
        int hours = examDuration.inHours;
        int minutes = examDuration.inMinutes % 60;
        setState(() {
          remainingTime = TimeOfDay(hour: hours, minute: minutes);
          ExamScreen.remainingTime = remainingTime;
        });
      });
    }
  }

  Future<String> fetchSnapShot() async {
    String strSubject = widget.subject.title.toString().toLowerCase();
    String snapshot = await DefaultAssetBundle.of(context)
        .loadString('assets/json/$strSubject.json');
    if (snapshot.isNotEmpty) {
      fetchdata(snapshot);
      return snapshot;
    }
    return null;
  }

  setSelectedRadio(int value, index) {
    setState(() {
      selectedRadio[index] = value;
      ExamScreen.currentAnswers = selectedRadio;
    });
  }

  void storeExamState() {
    if (selectedRadio
        .every((element) => element == null || selectedRadio.isEmpty)) {
      return null;
    }
    double totalQuestions = selectedRadio.length.toDouble();
    double answeredQuestions = selectedRadio.length.toDouble();
    selectedRadio.forEach((element) {
      if (element == null) {
        answeredQuestions--;
      }
    });
    double percentile = (answeredQuestions / totalQuestions) * 100;

    saveExamState(
      examState: RecentExamState(
        answers: selectedRadio.map((e) {
          if (e != null) {
            return e.toString();
          } else {
            return null;
          }
        }).toList(),
        title: widget.subject.title,
        year: widget.year,
        percentile: percentile,
        remainingTime: [
          remainingTime.hour.toString(),
          remainingTime.minute.toString(),
        ],
      ),
    );
  }

  void toResultScreen() {
    int result = 0;
    for (var i = 0; i < selectedRadio.length; i++) {
      if (selectedRadio[i] ==
          answerProvider(
              Answer(subject: widget.subject.title, year: widget.year))[i]) {
        result++;
      }
    }
    int totalQuestions = selectedRadio.length;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return ResultScreen(
          grade: result,
          outOf: totalQuestions,
        );
      }),
    );
  }

  getDataFromRecent() {
    if (widget.answersFromRecent != null) {
      selectedRadio = widget.answersFromRecent.map((e) {
        if (e != null) {
          return int.parse(e);
        } else {
          return null;
        }
      }).toList();
    }
  }

  Future<bool> _onWillPop() async {
    if (evaluate == true) {
      Navigator.popUntil(context, (route) => route.isFirst);
      return null;
    }
    return await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Save and Exit?'),
                content: Text(
                  'Do you want to save and exit?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text('No'),
                  ),
                  FlatButton(
                    onPressed: () {
                      currentRoute = 'homeScreen';
                      storeExamState();
                      if (_timer != null) _timer.cancel();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ),
                      );
                    },
                    child: Text('Yes'),
                  ),
                ],
              );
            }) ??
        false;
  }

  startTime() async {
    var duration = new Duration(seconds: 5);
    if (currentRoute != 'examScreen') {
      if (_noContentTimer != null) _noContentTimer.cancel();
      return null;
    }
    _noContentTimer = Timer(duration, toNoContentScreen);
  }

  void toNoContentScreen() {
    if (questions.isEmpty) {
      if (_noContentTimer != null) _noContentTimer.cancel();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return WillPopScope(
            onWillPop: () {
              Navigator.popUntil(context, (route) => route.isFirst);
              return null;
            },
            child: NoContentScreen(),
          );
        }),
      );
    }
  }

  Color optionsColorProvider(int index, int option) {
    Answer answer =
        new Answer(subject: widget.subject.title, year: widget.year);
    if (answerProvider(answer).length == 0) {
      return Colors.black;
    }
    if (evaluate == true && answerProvider(answer)[index] == option) {
      return Colors.green;
    }

    return (evaluate && selectedRadio[index] == option)
        ? (selectedRadio[index] == answerProvider(answer)[index])
            ? Colors.green
            : Colors.red
        : Colors.black;
  }

  void submitAnswer() {
    Answer answer =
        new Answer(subject: widget.subject.title, year: widget.year);
    if (answerProvider(answer).length == 0) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content:
              Text('No answers for ${widget.subject.title} ${widget.year}')));
      return null;
    }
    if (selectedRadio.every((element) => element != null)) {
      setState(() {
        this.evaluate = true;
        ExamScreen.readyToEvaluate = evaluate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    getDataFromRecent();
  }

  @override
  void dispose() {
    if (_timer != null) _timer.cancel();
    if (_noContentTimer == null) _noContentTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    startTime();
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: getProportionateScreenHeight(80)),
            child: Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              child: FutureBuilder(
                future: fetchSnapShot(),
                builder: (context, snapshot) {
                  return snapshot.data == null || questions.isEmpty
                      ? Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Image.asset(
                              'assets/gifs/pcpp-loading-boxes.gif',
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : ListView.builder(
                          // itemCount: questions.length,
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(26),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(16),
                                    ),
                                    child: Text(
                                      '${questions[index].question} \n',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      RadioListTile<int>(
                                        value: 0,
                                        isThreeLine: false,
                                        title: Text(
                                          questions[index].optionA,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                optionsColorProvider(index, 0),
                                          ),
                                        ),
                                        groupValue: selectedRadio[index],
                                        onChanged: (value) => evaluate
                                            ? null
                                            : setSelectedRadio(value, index),
                                        activeColor: Colors.blue[800],
                                      ),
                                      RadioListTile<int>(
                                        value: 1,
                                        isThreeLine: false,
                                        title: Text(
                                          questions[index].optionB,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                optionsColorProvider(index, 1),
                                          ),
                                        ),
                                        groupValue: selectedRadio[index],
                                        onChanged: (value) => evaluate
                                            ? null
                                            : setSelectedRadio(value, index),
                                        activeColor: Colors.blue[800],
                                      ),
                                      RadioListTile<int>(
                                        value: 2,
                                        isThreeLine: false,
                                        title: Text(
                                          questions[index].optionC,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                optionsColorProvider(index, 2),
                                          ),
                                        ),
                                        groupValue: selectedRadio[index],
                                        onChanged: (value) => evaluate
                                            ? null
                                            : setSelectedRadio(value, index),
                                        activeColor: Colors.blue[800],
                                      ),
                                      RadioListTile<int>(
                                        value: 3,
                                        isThreeLine: false,
                                        title: Text(
                                          questions[index].optionD,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                optionsColorProvider(index, 3),
                                          ),
                                        ),
                                        groupValue: selectedRadio[index],
                                        onChanged: (value) => evaluate
                                            ? null
                                            : setSelectedRadio(value, index),
                                        activeColor: Colors.blue[800],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: getProportionateScreenHeight(80),
              decoration: BoxDecoration(color: Colors.white),
              width: SizeConfig.screenWidth,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20),
                        vertical: getProportionateScreenHeight(10),
                      ),
                      child: InkWell(
                        splashColor: kButtonSplashColor,
                        highlightColor: Colors.transparent,
                        onTap: (questions != null)
                            ? (!evaluate)
                                ? submitAnswer
                                : toResultScreen
                            : null,
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(26),
                        ),
                        child: Container(
                          height: getProportionateScreenHeight(60),
                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              getProportionateScreenWidth(26),
                            ),
                            color: kButtonColor,
                          ),
                          child: Center(
                            child: Text(
                              !evaluate ? 'Submit answer' : 'See report',
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
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(8),
                      ),
                      child: Center(
                        child: FutureBuilder(
                          future: getRecentExamState(),
                          builder: (context, snapshot) {
                            return snapshot != null
                                ? Text(
                                    '${remainingTime.hour.toString().padLeft(2, '0')} : ${remainingTime.minute.toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(20),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    '00 : 00',
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(20),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
