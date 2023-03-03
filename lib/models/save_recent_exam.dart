import 'package:shared_preferences/shared_preferences.dart';

class RecentExamState {
  String title;
  List<String> answers;
  double percentile;
  int year;
  List<String> remainingTime;

  RecentExamState({
    this.title,
    this.answers,
    this.percentile,
    this.year,
    this.remainingTime,
  });
}

RecentExamState examState = RecentExamState();

saveExamState({RecentExamState examState}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('title', examState.title);
  sharedPreferences.setStringList('answers', examState.answers);
  sharedPreferences.setInt('year', examState.year);
  sharedPreferences.setDouble('percentile', examState.percentile);
  sharedPreferences.setStringList('remainingTime', examState.remainingTime);
}

Future<RecentExamState> getRecentExamState() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  examState.title = sharedPreferences.getString('title');
  examState.answers = sharedPreferences.getStringList('answers');
  examState.year = sharedPreferences.getInt('year');
  examState.percentile = sharedPreferences.getDouble('percentile');
  examState.remainingTime = sharedPreferences.getStringList('remainingTime');
  print(examState.remainingTime);
  return examState;
}
