import 'package:flutter/material.dart';
import 'package:movies_app/screens/home_screen/Home_Widget/widgets/popular_slider.dart';
import 'package:movies_app/screens/home_screen/Home_Widget/widgets/new_release.dart';
import 'package:movies_app/screens/home_screen/Home_Widget/widgets/recommended.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(5),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [PopularSlider(),
            NewRelease(),
            Recommended()],
        ),
      ),
    );
  }
}
