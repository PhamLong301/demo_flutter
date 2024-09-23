import 'package:demo_flutter/firebase/ui/register_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/firebase_controller.dart';

class FirebaseLogin extends StatefulWidget {
  const FirebaseLogin({super.key});

  @override
  State<FirebaseLogin> createState() => _FirebaseLoginState();
}

class _FirebaseLoginState extends State<FirebaseLogin> {
  final AuthController authController = Get.find();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Circular border
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập email';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Mật khẩu",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Circular border
                ),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authController.login(emailController.text.trim(),
                    passwordController.text.trim());
              },
              child: Text("Đăng nhập"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Chưa có tài khoản? ",
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => FirebaseRegister());
                  },
                  child: Text(
                    "Đăng ký ngay",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            const Text('Hoặc đăng nhập bằng'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // authController.signInWithGoogle();
                  },
                  icon: Image.asset(
                    'assets/google.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/facebook.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
