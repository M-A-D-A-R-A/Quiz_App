import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:quiz_app/models/sheet_form.dart';


class FormController {
  // Callback function to give response of status of current request.
  final void Function(String) callback;

  // Google App Script Web URL
  static const String URL = "https://script.google.com/macros/s/AKfycbzPXrypeUz--NXZ60HA7G-By_YREeV0SxOh1rddEg/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  FormController(this.callback);

  void submitForm(FeedbackForm feedbackForm) async{
    try{
      await http.get(URL + feedbackForm.toParams()).then(
          (response){
            callback(convert.jsonDecode(response.body)['status']);
          });
    } catch(e){
      print(e);
    }
  }
}