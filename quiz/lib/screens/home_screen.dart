import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz/screens/quiz_purchase_screen.dart';

import '../common/alert_util.dart';
import '../common/theme_helper.dart';
import '../stores/quiz_store.dart';
import '../widgets/disco_button.dart';
import 'quiz_category.dart';
import 'quiz_history_screen.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final QuizStore _quizStore = QuizStore();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: navigationDrawer(),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            decoration: ThemeHelper.fullScreenBgBoxDecoration(),
            child: Column(
              children: [
                drawerToggleButton(),
                Column(
                  children: [
                    headerText("Đố Vui"),
                    const SizedBox(height: 30),
                    ...homeScreenButtons(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Drawer navigationDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Trò Chơi Đố Vui",
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),
                Text(
                  "Phiên bản: 1.00",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Trang chủ'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
          ),
          ListTile(
            title: const Text('Bắt đầu chơi'),
            onTap: () async {
              var quiz = await _quizStore.getRandomQuizAsync();
              Navigator.pushNamed(context, "/quiz", arguments: quiz);
            },
          ),
          ListTile(
            title: const Text('Danh mục câu đố'),
            onTap: () {
              Navigator.pushNamed(context, QuizCategoryScreen.routeName);
            },
          ),
          ListTile(
            title: const Text('Lịch sử chơi'),
            onTap: () {
              Navigator.pushNamed(context, QuizHistoryScreen.routeName);
            },
          ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            title: const Text('Giới thiệu'),
            onTap: () {
              AlertUtil.showAlert(
                  context, "About us", "More at ...");
            },
          ),
          ListTile(
            title: const Text('Thoát'),
            onTap: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget drawerToggleButton() {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20),
      alignment: Alignment.topLeft,
      child: GestureDetector(
        child: const Image(
          image: AssetImage("assets/icons/menu.png"),
          width: 36,
        ),
        onTap: () {
          _key.currentState!.openDrawer();
        },
      ),
    );
  }

  Text headerText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 72,
          color: ThemeHelper.accentColor,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
                color: ThemeHelper.shadowColor,
                offset: const Offset(-5, 5),
                blurRadius: 30)
          ]),
    );
  }

  List<Widget> homeScreenButtons(BuildContext context) {
    return [
      Column(
        children: [
          DiscoButton(
            onPressed: () async {
              var quiz = await _quizStore.getRandomQuizAsync();
              Navigator.pushNamed(context, QuizScreen.routeName, arguments: quiz);
            },
            child: const Text(
              "Bắt đầu chơi",
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
            isActive: true,
          ),
          DiscoButton(
            onPressed: () {
              Navigator.pushNamed(context, QuizCategoryScreen.routeName);
            },
            child: Text(
              "Danh mục",
              style: TextStyle(fontSize: 30, color: ThemeHelper.primaryColor),
            ),
          ),
          DiscoButton(
            onPressed: () {
              Navigator.pushNamed(context, QuizHistoryScreen.routeName);
            },
            child: Text(
              "Lịch sử chơi",
              style: TextStyle(fontSize: 30, color: ThemeHelper.primaryColor),
            ),
          ),
          DiscoButton(
            onPressed: () {
              Navigator.pushNamed(context, QuizPurchaseScreen.routeName);
            },
            child: Text(
              "Mua lượt chơi",
              style: TextStyle(fontSize: 30, color: ThemeHelper.primaryColor),
            ),
          ),
        ],
      ),

    ];
  }
}
