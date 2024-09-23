// lib/controllers/auth_controller.dart
import 'package:demo_flutter/api_postman/ui/detail_phone_screen.dart';
import 'package:demo_flutter/api_postman/ui/products_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../firebase/ui/login_ui.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;

  void register(String email, String password) async {
    try {
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.back();
      Get.offAll(() => FirebaseLogin());
    } catch (e) {
      Get.back();
      Get.snackbar("Lỗi đăng ký", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void login(String email, String password) async {
    try {
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.back();
      Get.offAll(() => ProductsList());
    } catch (e) {
      Get.back();
      Get.snackbar("Lỗi đăng nhập", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signInWithGoogle() async {

  }

  void signInWitFacebook() async {

  }

  void signOut() async {
    await auth.signOut();
    Get.offAll(() => FirebaseLogin());
  }

  @override
  void onReady() {
    super.onReady();
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.offAll(() => FirebaseLogin());
      } else {
        Get.offAll(() => ProductsList());
      }
    });
  }
}
