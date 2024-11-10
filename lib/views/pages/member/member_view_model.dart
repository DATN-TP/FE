import 'dart:math';
import 'dart:developer' as dev;

import 'package:ResiEasy/models/user_model.dart';
import 'package:ResiEasy/services/api_service.dart';
import 'package:ResiEasy/services/user_service.dart';
import 'package:flutter/material.dart';

class MemberViewModel extends ChangeNotifier{

  final UserService userService = UserService(ApiService());

  List<User> _listUser = [];

  List<User> get listUser => _listUser;
  bool _isLoading = false;
  String? _error;

    bool get isLoading => _isLoading;
  String? get error => _error;


  //get user by apartment
  Future<void> getListUserByApartment(String id) async {
       _isLoading = true;
    final response = await userService.getListUserByApartment(id);
    _listUser = response;
    _error = null;
    _isLoading = false;
    notifyListeners();
    }



}