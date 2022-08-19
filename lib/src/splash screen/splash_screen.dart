import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kittys_tavern/src/animations/fade_in.dart';
import 'package:kittys_tavern/src/menu/menu_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    Timer.periodic(
      const Duration(seconds: 5),
      (Timer timer) {
        timer.cancel();

        // Navigate to the Menu. If the user leaves and returns to
        // the app after it has been killed while running in the
        // background, the navigation stack is restored.
        Navigator.pushReplacementNamed(
          context,
          MenuView.routeName,
        );
      },
    );

    return Container(
      color: Colors.black,
      child: FadeIn(
        duration: const Duration(seconds: 2),
        delay: const Duration(seconds: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 350.0,
            ),
            LoadingAnimationWidget.stretchedDots(
              color: Colors.white,
              size: 100,
            ),
            Text(
              'stocking the bar...',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
