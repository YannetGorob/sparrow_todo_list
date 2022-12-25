import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sparrow_todo_list/common/app_colors.dart';
import 'package:sparrow_todo_list/feature/data/models/account/user_model.dart';
import 'package:sparrow_todo_list/feature/data/models/group/get_groups_model.dart';

class AppSettings {
  static const String domain = 'http://user22950.realhost-free.net/';
  static String? token;
  static UserModel? user;
  static GroupModel? group;

  static http.Client client = http.Client();
}

class ValidateEmail {
  static bool validateEmail(String input) {
    if (input == null) {
      return false;
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(input);

    if (emailValid) {
      return true;
    }
    return false;
  }
}

class TextFieldDecoration {
  static OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: AppColors.helpTextColor),
    borderRadius: BorderRadius.circular(10.0),
  );
  static OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderSide:
        BorderSide(width: 1, color: AppColors.mainColor.withOpacity(0.7)),
    borderRadius: BorderRadius.circular(10.0),
  );
  static OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: Colors.red),
    borderRadius: BorderRadius.circular(10.0),
  );
  static OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: Colors.red),
    borderRadius: BorderRadius.circular(10.0),
  );
}
