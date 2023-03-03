import 'dart:convert';

class ChoiceQuestion {
  final String question, optionA, optionB, optionC, optionD;

  ChoiceQuestion({
    this.question,
    this.optionA,
    this.optionB,
    this.optionC,
    this.optionD,
  });

  factory ChoiceQuestion.fromJson(
    Map<String, dynamic> json,
  ) {
    return ChoiceQuestion(
      question: json['question'],
      optionA: json['options'][0]['option'],
      optionB: json['options'][1]['option'],
      optionC: json['options'][2]['option'],
      optionD: json['options'][3]['option'],
    );
  }
}

List<ChoiceQuestion> fetchQuestion(String response, String year) {
  Map<String, dynamic> decodeMap = jsonDecode(response);
  List<dynamic> dynamicList = decodeMap[year];
  List<ChoiceQuestion> questions = [];
  if (dynamicList != null)
    dynamicList.forEach((element) {
      questions.add(ChoiceQuestion.fromJson(element));
    });
  return questions;
}
