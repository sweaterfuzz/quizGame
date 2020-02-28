import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> scoreCard = [];

  void checkAnswer(bool userAnswer) {
    setState(() {
      if (userAnswer == quizBrain.getQuestionAnswer()) {
        scoreCard.add(Icon(Icons.check, color: Colors.green));
      } else {
        scoreCard.add(Icon(Icons.close, color: Colors.red));
      }});

    if (quizBrain.isFinished()){
      Alert(
      context: context,
      type: AlertType.info,
      title: "Quizzler",
      desc: "You've reached the end of the quiz.",
      buttons: [
        DialogButton(
          child: Text(
            "Reset quiz",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            resetQuiz();
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
    } else {
      quizBrain.nextQuestion();
    }
  }

  void resetQuiz() {
    setState(() {
      quizBrain.resetQuestions();
      scoreCard = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: scoreCard,
          ),
        )
      ],
    );
  }
}
