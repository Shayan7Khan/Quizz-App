//There are three extremely important (stateful) widget lifecycle methods you should be aware of:
//initState(): Executed by Flutter when the StatefulWidget's State object is initialized
//build(): Executed by Flutter when the Widget is built for the first time AND after setState() was called
//dispose(): Executed by Flutter right before the Widget will be deleted (e.g., because it was displayed conditionally)

import 'package:flutter/material.dart';
import 'package:quizz_app/questions_screen.dart';
import "package:quizz_app/start_screen.dart";
import 'package:quizz_app/questions.dart';
import 'package:quizz_app/result_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswer = [];
  //we can also store widgets in variables not just numbers or text.
  //The ? tells dart that the variable may contain a widget or null.
  var activeScreen = 'start-quiz';

  //A method that we wanna add to our state class to do some extra initialization work when that state object is created for the first time. It will execute once the object is created but then will never be executed thereafter again."Perfect for some general initialization work".
  //below is one way of rendering content conditionally which is by using initState.
  // void initState() {
  //   super.initState();
  //   activescreen = StartScreen(switchscreen);
  // }

  void switchScreen() {
    //when you call a set state in a state class, flutter will re-execute the build method and compare the result of executing that code to the result it got last time from execution and if there are any differences it updates the rendered UI accordingly .
    setState(
      () {
        activeScreen = 'question-screen';
      },
    );
  }

  void chooseAnswer(String answers) {
    //Adding answers to the list
    selectedAnswer.add(answers);
    //to avoid the error we get at the end after we are done with all the questions
    setState(
      () {
        if (selectedAnswer.length == questions.length) {
          activeScreen = 'results-screen';
        }
      },
    );
  }

  void restartQuiz() {
    setState(() {
      selectedAnswer = [];
      activeScreen = 'question-screen';
    });
  }

  @override
  Widget build(context) {
    //below is "Ternary Expression" in which the child widget gets the value based on condition. Its the same as the if-else statements. In this we first provide the condition which uses "==" this sign and if the conidition is true the part after "?" is yielded if its false the part after ":" is yielded.
    //then we can use the "screenwidget" variable in the child making it more readable.
    //Yet this is another way of rendering content conditionally
    // Widget screenwidget = activeScreen == 'start-quiz'
    //           ? StartScreen(switchScreen)
    //           : const QuestionsScreen();

    Widget screenwidget = StartScreen(switchScreen);

    //another apporach that we can use instead of "Ternary expression" is below which is the if-else approach
    if (activeScreen == 'question-screen') {
      //passing the chooseAnswer function as a value to QuestionScreen.
      screenwidget = QuestionsScreen(
        chooseAnswer,
      );
    }

    if (activeScreen == 'results-screen') {
      screenwidget = ResultScreen(selectedAnswer, restartQuiz);
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: screenwidget),
      ),
    );
  }
}
