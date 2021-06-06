import 'package:flutter/material.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/widgets/widgets.dart';

class Results extends StatefulWidget {
  final int correct, incorect, total;
  Results(
      {@required this.correct, @required this.incorect, @required this.total});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.correct}/${widget.total}",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "You Answered ${widget.correct} answer correctly and ${widget.incorect} answers incorrectly",
                style: TextStyle(fontSize: 15, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: blueButton(
                    context: context,
                    label: "Go to home",
                    buttonWidth: MediaQuery.of(context).size.width / 2),
              )
            ],
          ),
        ),
      ),
    );
  }
}
