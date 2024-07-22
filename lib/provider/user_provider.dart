import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:travel_admin/components/messageHepler.dart';
import 'package:travel_admin/models/user_model.dart';
import 'package:travel_admin/router/router.dart';
import 'package:travel_admin/service/auth_service.dart';

class UserProvider extends ChangeNotifier {
  final authService = AuthService();

  FirebaseAuth auth = FirebaseAuth.instance;
  UserModel? user;
  List<dynamic> _users = [];
  bool _loading = false;
  bool _success = false;
  bool get loading => _loading;
  bool get success => _success;
  List<dynamic> get users => _users;
  bool chatsending = false;
  File? image;
  ImagePicker imagepicker = ImagePicker();

  Future<void> validateToken() async {
    final result = await authService.validateToken();
    if (result != null) {
      navService.pushNamedAndRemoveUntil(RouteAPI.bottom);
    } else {
      navService.pushNamedAndRemoveUntil(RouteAPI.login);
    }
  }

  Future<void> getUser() async {
    _loading = true;
    try {
      final result = await authService.getUsers();
      if (result!.length > 0) {
        _loading = false;
        _users = result;
        notifyListeners();
      }
    } catch (e) {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      final result = await authService.logout();
      if (result == 1) {
        navService.pushNamedAndRemoveUntil(RouteAPI.login);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      final result = await authService.register(
        email: email,
        password: password,
      );
      navService.goBack();

      if (result == 1) {
        MessageHepler.showSnackBarMessage(
            isSuccess: true, message: "Register Success");

        navService.pushNamedAndRemoveUntil(RouteAPI.login);
        notifyListeners();
      } else {
        MessageHepler.showSnackBarMessage(
            isSuccess: false, message: "Email Already!");
      }
    } catch (e) {
      MessageHepler.showSnackBarMessage(
          isSuccess: false, message: "Email Already!");
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await authService.login(email: email, password: password);
      navService.goBack();
      if (result != null) {
        user = result;
        navService.pushNamedAndRemoveUntil(RouteAPI.dashboard);
        // user.
      } else {
        MessageHepler.showSnackBarMessage(
            isSuccess: false, message: "ອີເມວ ແລະ ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ");
      }
    } catch (e) {
      navService.goBack();
      MessageHepler.showSnackBarMessage(
          isSuccess: false, message: "ອີເມວ ແລະ ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ");
    }
  }

  Future<void> pickimage() async {
    try {
      final img = await imagepicker.pickImage(source: ImageSource.gallery);
      if (img != null) {
        image = File(await img.path);
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
