import 'package:flutter/material.dart';
import 'package:grade_12_exams/models/question_fetcher.dart';
import 'package:grade_12_exams/models/values.dart';

import '../../size_config.dart';

class QuestionsList extends StatefulWidget {
  final int year;
  final Subject subject;
  QuestionsList({
    Key key,
    @required this.evaluate,
    @required this.year,
    @required this.subject,
  }) : super(key: key);
  final bool evaluate;

  @override
  QuestionsListState createState() {
    return QuestionsListState(evaluate: evaluate);
  }
}

class QuestionsListState extends State<QuestionsList> {
  bool evaluate;
  List<ChoiceQuestion> questions;
  List<int> selectedRadio = List<int>.filled(0, 0, growable: true);

  QuestionsListState({this.evaluate});

  fetchdata(String data) async {
    String strSubject = widget.subject.title.toString().toLowerCase();

    questions = fetchQuestion(data, strSubject);
    // selectedRadio.length = questions.length;
    selectedRadio.length = 5;
  }

  Future<String> fetchSnapShot() async {
    String strSubject = widget.subject.title.toString().toLowerCase();
    String snapshot = await DefaultAssetBundle.of(context)
        .loadString('assets/json/$strSubject.json');
    fetchdata(snapshot);
    return snapshot;
  }

  setSelectedRadio(int value, index) {
    setState(() {
      selectedRadio[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: FutureBuilder(
        future: fetchSnapShot(),
        builder: (context, snapshot) {
          return snapshot.data == null
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
                  itemCount: questions.length,
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
                              horizontal: getProportionateScreenWidth(16),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RadioListTile<int>(
                                value: 0,
                                isThreeLine: false,
                                title: Text(
                                  questions[index].optionA,
                                  style: TextStyle(
                                    color: evaluate ? Colors.red : Colors.black,
                                  ),
                                ),
                                groupValue: selectedRadio[index],
                                onChanged: (value) =>
                                    setSelectedRadio(value, index),
                                activeColor: Colors.green,
                              ),
                              RadioListTile<int>(
                                value: 1,
                                isThreeLine: false,
                                title: Text(questions[index].optionB),
                                groupValue: selectedRadio[index],
                                onChanged: (value) =>
                                    setSelectedRadio(value, index),
                                activeColor: Colors.green,
                              ),
                              RadioListTile<int>(
                                value: 2,
                                isThreeLine: false,
                                title: Text(questions[index].optionC),
                                groupValue: selectedRadio[index],
                                onChanged: (value) =>
                                    setSelectedRadio(value, index),
                                activeColor: Colors.green,
                              ),
                              RadioListTile<int>(
                                value: 3,
                                isThreeLine: false,
                                title: Text(questions[index].optionD),
                                groupValue: selectedRadio[index],
                                onChanged: (value) =>
                                    setSelectedRadio(value, index),
                                activeColor: Colors.green,
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
    );
  }
}
