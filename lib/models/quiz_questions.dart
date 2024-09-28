class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> getShuffledAnswers() {
    //The below method is called chaining, where a method is called on the result of calling another functional method. We used shuffle to shuffle the answers in our list and it also changes the list whereas mapping didn't changed the list. But we also need to return this updated list but shuffle is a void function and doesnot return so we store it into a variable and return that variable
    //List.of(answers).shuffle()

    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
