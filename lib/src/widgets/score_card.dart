import 'package:flutter/material.dart';

import '../utils/image.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({
    super.key,
    required this.score,
  });

  final ValueNotifier<int> score;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: score,
      builder: (context, score, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                Image.asset(appImage.score_bg, width: 150,),
                Padding(
                  padding: const EdgeInsets.only(left: 18, top: 13),
                  child: Text(
                    'Score:$score'.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium!
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}