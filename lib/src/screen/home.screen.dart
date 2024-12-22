import 'package:brick_smasher/src/auth/auth.wrapper.dart';
import 'package:brick_smasher/src/function/functions.dart';
import 'package:brick_smasher/src/screen/leaderboard.dart';
import 'package:brick_smasher/src/screen/settings.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/const.dart';
import '../utils/image.dart';
import '../utils/user.model.dart';
import '../widgets/game_app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlayerRank(setState);
    fetchUserData();
    loadUserData();
  }

  void loadUserData() async {
    UserModel? fetchedUser = await fetchUserData();
    // AppData? fetchedApp = await fetchAppData();
    setState(() {
      userModel = fetchedUser;
      // appData = fetchedApp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            VxBox(
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            appImage.score_bg,
                            width: 125,
                          ),
                          Row(
                            children: [
                              5.widthBox,
                              Image.asset(
                                appImage.star_btn,
                                width: 40,
                              ),
                              "  ${userModel!.score.toString()}"
                                  .text
                                  .white
                                  .bold
                                  .size(20)
                                  .make(),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Stack(
                        children: [
                          Image.asset(
                            appImage.blank_square_btn,
                            width: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => Leaderboard());
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.leaderboard,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      5.widthBox,
                      GestureDetector(
                        onTap: () async {
                          Get.to(()=>SettingsScreen());
                        },
                        child: Image.asset(
                          appImage.setting_btn,
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                  20.heightBox,
                  Row(
                    children: [
                      Stack(
                        children: [

                          Image.asset(
                            appImage.score_bg,
                            width: 155,
                          ),
                          Row(
                            children: [
                              5.widthBox,
                              if(rank == 1 )
                              Image.asset(
                                appImage.frame1,
                                width: 50,
                              ),
                              if(rank == 2 )
                                Image.asset(
                                  appImage.frame2,
                                  width: 50,
                                ),
                              if(rank == 3 )
                                Image.asset(
                                  appImage.frame3,
                                  width: 50,
                                ),
                              if(rank! > 4 )
                              Image.asset(
                                appImage.frame3,
                                width: 50,
                              ),
                              "  ${userModel!.username.toString()}"
                                  .text
                                  .white
                                  .bold
                                  .size(13)
                                  .make(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  10.heightBox,
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      // scrollDirection: Axis.horizontal,
                      children: [
                        VxBox(
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  level = 5;
                                });
                                Get.to(() => GameApp());
                              },
                              child: Image.asset(appImage.easy_btn),
                            ),
                          ),
                        )
                            .margin(const EdgeInsets.only(bottom: 20))
                            .height(120)
                            .width(200)
                            .rounded
                            .make(),
                        VxBox(
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  level = 7;
                                });
                                Get.to(() => GameApp());
                              },
                              child: Image.asset(appImage.medium_btn),
                            ),
                          ),
                        )
                            .margin(EdgeInsets.only(bottom: 20))
                            .height(120)
                            .width(200)
                            .rounded
                            .make(),
                        VxBox(
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  level = 10;
                                });
                                Get.to(() => GameApp());
                              },
                              child: Image.asset(appImage.hard_btn),
                            ),
                          ),
                        )
                            .margin(EdgeInsets.only(bottom: 20))
                            .height(120)
                            .width(200)
                            .rounded
                            .make()
                      ],
                    ),
                  ),
                ],
              ),
            )
                .height(MediaQuery.of(context).size.height)
                .width(MediaQuery.of(context).size.width)
                .color(Colors.blueAccent)
                .padding(const EdgeInsets.only(
                    left: 20, top: 35, right: 20, bottom: 20))
                .make(),
          ],
        ),
      ),
    );
  }
}
