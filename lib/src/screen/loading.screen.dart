import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/image.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VxBox(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ))
          .height(MediaQuery.of(context).size.height)
          .width(MediaQuery.of(context).size.width)
          .bgImage(DecorationImage(image: AssetImage(appImage.bg), fit: BoxFit.cover))
          .make(),
    );
  }
}
