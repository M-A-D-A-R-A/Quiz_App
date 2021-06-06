import 'package:flutter/material.dart';
import 'package:quiz_app/helper/constants.dart';
import 'package:quiz_app/helper/functions.dart';
import 'package:quiz_app/models/sheet_form.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/services/sheet_controller.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/signin.dart';
import 'package:quiz_app/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  final Function toogleView;

  SignUp({this.toogleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController totalMarks = TextEditingController();

  // text feild
  bool _loading = false;
  String email = '', password = '', name = "";

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      FeedbackForm feedbackForm = FeedbackForm(
        nameController.text,
        emailController.text,
        totalMarks.text,
      );

      FormController formController = FormController((String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          print("Feedback Submitted");
          //
          // _showSnackbar("Feedback Submitted");
        } else {
          print("Error Occurred!");
          // _showSnackbar("Error Occurred!");
        }
      });

      // _showSnackbar("Submitting Feedback");

      // Submit 'feedbackForm' and save it in Google Sheet

      formController.submitForm(feedbackForm);
    }
  }

  // Method to show snackbar with 'message'.
  // _showSnackbar(String message) {
  //   final snackBar = SnackBar(content: Text(message));
  //   _scaffoldKey.currentState.Sc(snackBar);
  // }

  getInfoAndSignUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });

      await authService
          .signUpwithEmailandPassword(email, password)
          .then((value) {
        Map<String, String> userInfo = {
          "userName": name,
          "email": email,
        };

        databaseService.addData(userInfo);

        Constants.saveUserLoggedInSharedPreference(true);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: _loading
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : Column(
                children: [
                  Spacer(),
                  Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            validator: (val) =>
                                val.isEmpty ? "Enter an Name" : null,
                            decoration: InputDecoration(hintText: "Name"),
                            onChanged: (val) {
                              name = val;
                            },
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (val) => validateEmail(email)
                                ? null
                                : "Enter correct email",
                            decoration: InputDecoration(hintText: "Email"),
                            onChanged: (val) {
                              email = val;
                            },
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (val) => val.length < 6
                                ? "Password must be 6+ characters"
                                : null,
                            decoration: InputDecoration(hintText: "Password"),
                            onChanged: (val) {
                              password = val;
                            },
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          GestureDetector(
                            onTap: () {
                              //_submitForm();
                              getInfoAndSignUp();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 20),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have and account? ',
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 17)),
                              GestureDetector(
                                onTap: () {
                                  widget.toogleView();
                                },
                                child: Container(
                                  child: Text('Sign In',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          decoration: TextDecoration.underline,
                                          fontSize: 17)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
      ),
    );
  }
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}
