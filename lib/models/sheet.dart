import 'package:flutter/cupertino.dart';
import 'package:quiz_app/models/user.dart';

class UserFeilds {
  static const String id = 'ID';
  static const String name = 'Name';
  static const String email = 'E-mail';
  static const String totalMarks = 'TotalMarks';
  static List<String> getFeilds() => [id, name, email, totalMarks];
}

class Users {
  final int id;
  final String name;
  final String email;
  final int totalMarks;

  const Users(
      {this.id,
      @required this.name,
      @required this.email,
      @required this.totalMarks});

  Users copy({int id, String name, String email, String totalMarks}) => Users(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      totalMarks: totalMarks ?? this.totalMarks);

  Map<String, dynamic> toJson() => {
        UserFeilds.id: id,
        UserFeilds.name: name,
        UserFeilds.email: email,
        UserFeilds.totalMarks: totalMarks,
      };
}
