class FeedbackForm {

  String _name;
  String _email;
  String _totalMarks;


  FeedbackForm(this._name, this._email, this._totalMarks);

  // Method to make GET parameters.
  String toParams() =>
      "?name=$_name&email=$_email&totalMarks=$_totalMarks";


}