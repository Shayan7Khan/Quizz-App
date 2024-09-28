import 'package:flutter/material.dart';
import 'package:quizz_app/answer.dart';
import 'package:quizz_app/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen(this.onSelectAnswer, {super.key});
  final void Function(String answers) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentquestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    //inorder to access the stateclass above we need to use the "widget" which will give us access to the widget class and its properties. We pass the selectedAnswer arguement inorder to know what the answer is
    widget.onSelectAnswer(selectedAnswer);
    //as the build method would not be executed again so we use the setState function which tells the flutter that the build method should be executed again.
    setState(
      () {
        currentquestionIndex++;
        //currentquestionIndex = currentquestionIndex + 1
        //currentquestionIndex +=1
        //both of the apporaches above can be used the one I used increments the value just by only 1 where as in the other approaches you can increment the value by 2 3 etc.
      },
    );
  }

  @override
  Widget build(context) {
    final currentquestion = questions[currentquestionIndex];
    return SizedBox(
      //"double.infinity" is a built-in dart feature use as much width as you can.
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentquestion.text,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 201, 153, 251),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            //Map allows you to convert the values in a list to other values. The function in the map will be executed automatically by dart for every list item. but converting our answer to answerbuttons are not enough because the "children" widget is a list itself and it doesnt accept another list. So we add spreading which is a built in method and thats done by adding 3 dots "..." infront of currentquestion.answer.map. This spread pull out the values of the list and place them as comma separated values. Goal is to dynamically generate answers buttons instead of hardcoding them.
            ...currentquestion.getShuffledAnswers().map(
              (answers) {
                return AnswerButton(
                  answers,
                  //passing the method to onTap as a value to change the questions after one of the answer button is tapped.
                  () {
                    answerQuestion(answers);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
