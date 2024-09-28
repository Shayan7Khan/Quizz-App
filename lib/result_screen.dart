import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_app/questions.dart';
import 'package:quizz_app/questions_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(this.chosenAnswers, this.onRestart, {super.key});

  final void Function() onRestart;

  final List<String> chosenAnswers;
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'questions-index': i,
          'questions': questions[i].text,
          'correct_answers': questions[i].answers[0],
          'user_answer': chosenAnswers[i],
        },
      );
    }
    return summary;
  }

  

  @override
  Widget build(context) {
    //Storing the List in the summaryData
    final summaryData = getSummaryData();
    //Storing the total number of questions
    final numTotalQuestions = questions.length;
    //Storing the number of answers that were correct
    //using where(built-in dart method) to create another list based on the original list to store or drop value in the list created by 'where'.
    //moreover we can also use an arrow function below which is more concise and instead of writing "return" and using curly brcaces etc we can just simply use the arrow function.
    final numCorrectAnswers = summaryData
        .where(
          (data) => data['user_answer'] == data['correct_answers'],
        )
        .length;
    //below is the other approach of writing the same piece of code without using the arrow function.
    // final numCorrectAnswers = summaryData.where(
    //   (data) {
    //     return data['user_answer'] == data['correct_answers'];
    //   },
    //   //using ".length" because we want number of correct answers not list of correct answers. This gives us the amount of items that were kept in the filtered list.
    // ).length;
    return SizedBox(
      //"double.infinity" is a built-in dart feature use as much width as you can.
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Injecting the values of Total-number-of-questions and correctly-answered questions by using the dollar sign with respect to its variable.
            Text(
              'You answerd $numCorrectAnswers out of $numTotalQuestions Questions.',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 230, 200, 253),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Quiz!'),
            )
          ],
        ),
      ),
    );
  }
}
