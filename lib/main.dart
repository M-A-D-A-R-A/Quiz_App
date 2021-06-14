import 'package:flutter/material.dart';
import 'package:quiz_app/api/sheets/user_sheets_api.dart';
import 'package:quiz_app/helper/functions.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/signin.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetsApi.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  bool _isLoggedin = false;
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  checkUserLoggedInStatus() async {
    _isLoggedin = await HelperFunctions.getUserLoggedInDeatails().then((value) {
      setState(() {
        _isLoggedin = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (_isLoggedin ?? false) ? Home() : SignIn(),
    );
  }
}
