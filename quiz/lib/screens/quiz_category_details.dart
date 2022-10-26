import 'package:flutter/material.dart';

import '../common/theme_helper.dart';
import '../models/category.dart';
import '../models/quiz.dart';
import '../stores/quiz_store.dart';

class QuizCategoryDetailsScreen extends StatefulWidget {
  static const routeName = '/categoryDetails';
  late Category category;

  QuizCategoryDetailsScreen(this.category, {Key? key}) : super(key: key);

  @override
  _QuizCategoryDetailsScreenState createState() =>
      _QuizCategoryDetailsScreenState(category);
}

class _QuizCategoryDetailsScreenState extends State<QuizCategoryDetailsScreen> {
  late Category category;

  _QuizCategoryDetailsScreenState(this.category);

  late List<Quiz> quizList = [];

  @override
  void initState() {
    var quizStore = QuizStore();
    quizStore.loadQuizListByCategoryAsync(category.id).then((value) {
      setState(() {
        quizList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.center,
          decoration: ThemeHelper.fullScreenBgBoxDecoration(),
          child: Column(
            children: [
              screenHeader(category),
              Expanded(
                child: categoryDetailsView(quizList),
              ),
            ],
          ),
        ),
      ),
    );
  }

  screenHeader(Category category) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          GestureDetector(
            child: const Image(
              image: AssetImage("assets/icons/back.png"),
              width: 40,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Text(
            "Câu Đố ${category.name}",
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }

  categoryDetailsView(List<Quiz> quizList) {
    return SingleChildScrollView(
      child: Column(
        children: quizList
            .map((quiz) => GestureDetector(
                  child: categoryDetailsItemView(quiz),
                  onTap: () {
                    Navigator.of(context).pushNamed("/quiz", arguments: quiz);
                  },
                ))
            .toList(),
      ),
    );
  }

  categoryDetailsItemBadge(Quiz quiz) {
    return Container(
      alignment: Alignment.topRight,
      child: Container(
        width: 150,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ThemeHelper.primaryColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            )),
        child: Text(
          "${quiz.questions.length} Câu hỏi",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  categoryDetailsItemView(Quiz quiz) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: ThemeHelper.roundBoxDeco(),
      child: Stack(
        children: [
          categoryDetailsItemBadge(quiz),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: ThemeHelper.roundBoxDeco(
                      color: const Color(0xffE1E9F6), radius: 10),
                  child: Image(
                    image: AssetImage(quiz.imagePath.isEmpty == true
                        ? category.imagePath
                        : quiz.imagePath),
                    width: 130,
                  ),
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quiz.title,
                          style: const TextStyle(fontSize: 22),
                        ),
                        Text(quiz.description),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
