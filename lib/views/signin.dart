import 'package:flutter/material.dart';
import 'package:quiz_app/helper/constants.dart';
import 'package:quiz_app/helper/functions.dart';
import 'package:quiz_app/models/sheet_form.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/services/sheet_controller.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/signup.dart';
import 'package:quiz_app/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  final Function toogleView;

  SignIn({this.toogleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  
  
   String email = '', password = '', name = "";
  AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();
  bool isLoading = false;
 getInfoAndSignUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
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
      appBar: AppBar(
        title: appBar(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Text("Welcome",style: TextStyle(fontSize: 20,),),
                    Spacer(),
                    TextFormField(
                      //controller: emailController,
                      validator: (val) {
                        return val.isEmpty ? "Enter Email Id" : null;
                      },
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
                      validator: (val) {
                        return val.isEmpty ? "Enter Password" : null;
                      },
                      decoration: InputDecoration(hintText: "Password"),
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          getInfoAndSignUp();
                        },
                        child: blueButton(context: context, label: "Sign In")),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 15.5),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text("Sign Up",
                                style: TextStyle(
                                    fontSize: 15.5,
                                    decoration: TextDecoration.underline))),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
