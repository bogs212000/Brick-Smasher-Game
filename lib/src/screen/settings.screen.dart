import 'package:brick_smasher/src/auth/auth.wrapper.dart';
import 'package:brick_smasher/src/screen/test.dart';
import 'package:brick_smasher/src/utils/colors.dart';
import 'package:brick_smasher/src/utils/image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
      ),
      body: VxBox(
              child: Column(
        children: [
          40.heightBox,
          VxCircle(
            backgroundImage: const DecorationImage(
                image: NetworkImage(
                    'https://e7.pngegg.com/pngimages/59/659/png-clipart-computer-icons-scalable-graphics-avatar-emoticon-animal-fox-jungle-safari-zoo-icon-animals-orange-thumbnail.png')),
          ),
          20.heightBox,
          GestureDetector(
            onTap: () async {
              // Get.to(()=> PuzzleScreen());
              await FirebaseAuth.instance.signOut();
              Get.offAll(AuthWrapper());
            },
            child: Image.asset(appImage.logout_btn, height: 50,),
          )
        ],
      ))
          .height(MediaQuery.of(context).size.height)
          .padding(EdgeInsets.all(20))
          .width(MediaQuery.of(context).size.width)
          .color(Colors.lightBlueAccent)
          .make(),
    );
  }
}
