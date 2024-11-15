import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:userdata/model/user.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  List<User> _user = [];

  bool _isLoading = false;

  String errorMessage = "";

  bool get isloading => _isLoading;
  List<User> get users => _user;

  Future<void> fetchUsers(String? username) async {
    String url = (username == null)
        ? "https://jsonplaceholder.typicode.com/users"
        : "https://jsonplaceholder.typicode.com/users?name=$username";

    try {
      _isLoading = true;
      errorMessage = '';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> userDatas = json.decode(response.body);
        _user = userDatas.map((user) => User.fromJson(user)).toList();
        if (username != null && _user.isEmpty) {
          errorMessage = "No User found with the name \"$username\"";
        }
      } else {
        errorMessage =
            "Server error: ${response.statusCode}. Please try again later.";
      }
    } on SocketException {
      errorMessage =
          "No internet connection. Please check your connection and try again.";
    } catch (e) {
      errorMessage = "An unexpected error occurred. Please try again.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
