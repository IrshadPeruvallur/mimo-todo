import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memo_todo/authentication/model/auth_model.dart';
import 'package:memo_todo/service/auth_service.dart';
import 'package:memo_todo/utils/handle_firebase_auth_exception.dart';

class AuthController extends ChangeNotifier {
  final AuthService authService = AuthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  Future<String?> registerUser() async {
    AuthModel authModel = AuthModel(
      email: emailController.text,
      password: passwordController.text,
      fullName: fullNameController.text,
    );

    var result = await authService.registerUser(authModel);

    if (result is FirebaseAuthException) {
      return handleFirebaseAuthException(result);
    }

    notifyListeners();
    return null;
  }

  Future<String?> loginUser() async {
    var result = await authService.loginUser(
      emailController.text,
      passwordController.text,
    );

    if (result is FirebaseAuthException) {
      return handleFirebaseAuthException(result);
    }

    notifyListeners();
    return null;
  }

  Future<String?> logoutUser() async {
    try {
      await authService.logoutUser();
      notifyListeners();
      return null;
    } catch (e) {
      return "Logout Error: $e";
    }
  }

  Future<String?> forgotPassword() async {
    var result = await authService.sendPasswordResetEmail(emailController.text);

    if (result is FirebaseAuthException) {
      return handleFirebaseAuthException(result);
    }

    notifyListeners();
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }
}
