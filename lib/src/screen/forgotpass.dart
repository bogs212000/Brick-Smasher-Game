import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:velocity_x/velocity_x.dart';

import '../function/auth.function.dart';
import '../utils/image.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: VxBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    Image.asset(appImage.score_bg, width: 200,),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 15),
                      child: "Forgot Password".text.white.bold.size(20).make(),
                    ),
                  ],
                ),
              ],
            ).animate()
                .fade(duration: 100.ms)
                .scale(delay: 100.ms),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  'Please enter your email'.text.white.size(15).make(),
                ],
              ).animate()
                  .fade(duration: 200.ms)
                  .scale(delay: 200.ms),
            ),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
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
                  .fade(duration: 300.ms)
                  .scale(delay: 300.ms),
            ),
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      if (emailController.text.isEmpty) {
                        Get.snackbar(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          'Notice',
                          'Please enter your email',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          duration: Duration(seconds: 3),
                          isDismissible:
                          false, // Make it non-dismissible until login is complete
                        );
                      } else {
                        Get.snackbar(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          'Loading',
                          'Please wait while we sending a change password link.',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.white,
                          colorText: Colors.blueAccent,
                          duration: Duration(seconds: 3),
                          isDismissible:
                          false, // Make it non-dismissible until login is complete
                        );
                        await AuthService().forgotPass(
                            emailController.text.trim().toLowerCase());
                        emailController.clear();
                      }
                    },
                    child: "Change Password".text.bold.make()),
              ],
            ),
          ],
        ),
      )
          .height(MediaQuery.of(context).size.height)
          .width(MediaQuery.of(context).size.width)
          .bgImage(DecorationImage(
              image: AssetImage(appImage.bg), fit: BoxFit.cover))
          .padding(
              const EdgeInsets.only(left: 20, top: 35, right: 40, bottom: 40))
          .make(),
    );
  }
}
