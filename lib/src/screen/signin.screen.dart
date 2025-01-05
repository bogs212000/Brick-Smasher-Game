
import 'package:brick_smasher/src/screen/forgotpass.dart';
import 'package:brick_smasher/src/screen/signup.dart';
import 'package:brick_smasher/src/screen/test.dart';
import 'package:brick_smasher/src/screen/test_sudoku.dart';
import 'package:brick_smasher/src/utils/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../function/auth.function.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(40),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(appImage.bg), fit: BoxFit.cover)),
        // color: Colors.blueAccent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    Image.asset(appImage.score_bg, height: 50,),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 10),
                      child: "Welcome".text.white.bold.size(20).make(),
                    ),
                  ],
                ),
              ],
            ).animate()
                .fade(duration: 100.ms)
                .scale(delay: 100.ms),
            20.heightBox,
            SizedBox(
              height: 50,
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Email',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ).animate()
                .fade(duration: 200.ms)
                .scale(delay: 200.ms),
            20.heightBox,
            SizedBox(
              height: 50,
              child: TextField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_isPasswordVisible,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                ),
              ),
            ).animate()
                .fade(duration: 300.ms)
                .scale(delay: 300.ms),
            15.heightBox,
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => SignUpPage());
                  },
                  child: 'Sign up'.text.white.bold.size(13).make().animate()
                      .fade(duration: 400.ms)
                      .scale(delay: 400.ms),
                ),
                Spacer(),
                ElevatedButton(
                    onPressed: () {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        if(!Get.isSnackbarOpen){
                          Get.snackbar(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            'Notice',
                            'Please input your email and password.',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.orange,
                            colorText: Colors.white,
                            isDismissible:
                            false, // Make it non-dismissible until login is complete
                          );
                        }

                      } else {
                        Get.snackbar(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          'Loading',
                          'Please wait while we process your login.',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.white,
                          colorText: Colors.blueAccent,
                          duration: Duration(seconds: 3),
                          isDismissible:
                          false, // Make it non-dismissible until login is complete
                        );
                        AuthService().signIn(
                            emailController.text.trim().toLowerCase(),
                            passwordController.text.trim());
                      }
                    },
                    child: 'Sign in'.text.bold.make()).animate()
                    .fade(duration: 400.ms)
                    .scale(delay: 400.ms),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                     // Get.to(()=> PuzzleScreen());
                     // Get.to(()=> TicTacToeGame());
                    Get.to(()=>ForgotPassword());
                  },
                  child: 'Forgot password'.text.white.bold.size(12).make().animate()
                      .fade(duration: 500.ms)
                      .scale(delay: 500.ms),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}