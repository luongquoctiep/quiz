import 'package:flutter/material.dart';
import 'common/route_generator.dart';
import 'common/theme_helper.dart';
import 'stores/quiz_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await QuizStore.initPrefs();
  runApp(const QuizApp());
}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      theme: ThemeHelper.getThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
