import 'package:flutter/material.dart';
import 'package:quiz/screens/quiz_history_screen.dart';

import '../common/theme_helper.dart';
import '../models/dto/quiz_result.dart';
import '../widgets/disco_button.dart';

class QuizResultScreen extends StatefulWidget {
  static const routeName = '/quizResult';
  QuizResult result;

  QuizResultScreen(this.result, {Key? key}) : super(key: key);

  @override
  _QuizResultScreenState createState() => _QuizResultScreenState(this.result);
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  QuizResult result;
  int totalQuestions = 0;
  double totalCorrect = 0;

  _QuizResultScreenState(this.result);

  @override
  void initState() {
    setState(() {
      totalCorrect = result.totalCorrect;
      totalQuestions = result.quiz.questions.length;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: ThemeHelper.fullScreenBgBoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            quizResultInfo(result),
            bottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget bottomButtons() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DiscoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Quay lại",
              style: TextStyle(color: Colors.deepPurple, fontSize: 20),
            ),
            width: 150,
            height: 50,
          ),
          DiscoButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, QuizHistoryScreen.routeName);
            },
            child: const Text(
              "Lịch sử",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            width: 150,
            height: 50,
            isActive: true,
          ),
        ],
      ),
    );
  }

  Widget quizResultInfo(QuizResult result) {
    return Column(
      children: [
        const Image(
          image: AssetImage("assets/images/quizResultBadge.png"),
        ),
        Text(
          "Xin chúc mừng!",
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          "Bạn đã hoàn thành trò chơi câu đố",
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          "Số điểm",
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          "$totalCorrect/$totalQuestions",
          style: Theme.of(context).textTheme.headline2,
        ),
      ],
    );
  }
}
