import 'package:brick_smasher/src/screen/home.screen.dart';
import 'package:brick_smasher/src/utils/image.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'overlay_screen.dart';
import 'score_card.dart';

import '../brick_breaker.dart';
import '../config.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final BrickBreaker game;

  @override
  void initState() {
    super.initState();
    game = BrickBreaker();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: ScoreCard(score: game.score),
          foregroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                Get.offAll(HomeScreen());
              },
              child:
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.asset(
                      appImage.back_btn,
                      height: 10,
                    ),
                  )),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: Container(
          decoration: const BoxDecoration(
            // image: DecorationImage(image: AssetImage(appImage.bg), fit: BoxFit.c),
            color: Colors.lightBlueAccent
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 1, left: 1, right: 1, bottom: 30),
              child: Center(
                child: Column(
                  // Modify from here...
                  children: [
                    Expanded(
                      child: FittedBox(
                        child: SizedBox(
                          width: gameWidth,
                          height: gameHeight,
                          child: GameWidget(
                            game: game,
                            overlayBuilderMap: {
                              PlayState.welcome.name: (context, game) =>
                                  const Padding(
                                    padding: EdgeInsets.all(50.0),
                                    child: OverlayScreen(
                                      title: 'TAP TO PLAY',
                                      subtitle: 'Slide the bat to bounce the ball',
                                    ),
                                  ),
                              PlayState.gameOver.name: (context, game) =>
                                  const OverlayScreen(
                                    title: 'GAME OVER',
                                    subtitle: 'Tap to Play Again',
                                  ),
                              PlayState.won.name: (context, game) =>
                                  const OverlayScreen(
                                    title: 'YOU WON!!!',
                                    subtitle: 'Tap to Play Again',
                                  ),
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ), // ,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
