import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});
   Future<void> addData(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await Firestore.instance.collection("users").snapshots();
  }

  Future<void> addQuizData(Map quizData, String quizid) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizid)
        .setData(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questionData, String quizId) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e) {
      print(e);
    });
  }

  getQuizezData() async {
    return await Firestore.instance.collection("Quiz").snapshots();
  }

  getQuiz(String quizId) async {
    return await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }
}
