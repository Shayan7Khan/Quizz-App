import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizz_app/summary_iterm.dart';
//we are using typecasting to tell dart that we know what kind of value we are expecting over here.
//we were getting an error that "int" cant be assigned to "string" so we used the ".toString()" function

//without expanded widget the column takes infinite amount of width, even if it goes beyond the screen boundaries. Expanded allows its child to take the availaible space along the flex widget main axis. Expanded allows it child which is column rightnow to take up the availaible space provided by the row as it is inside of the row widget.

//without expanded widget the column takes infinite amount of width, even if it goes beyond the screen boundaries. Expanded allows its child to take the availaible space along the flex widget main axis. Expanded allows it child which is column rightnow to take up the availaible space provided by the row as it is inside of the row widget.

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;
  @override
  Widget build(context) {
    return SizedBox(
      height: 300,
      //using singlechildscrollview widget because height of 300px exceeds the overall screen boundaries so with this it remains in
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map(
            (data) {
              return SummaryItems(data);
            },
          ).toList(),
        ),
      ),
    );
  }
}
