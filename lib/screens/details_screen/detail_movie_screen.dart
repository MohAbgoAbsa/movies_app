import 'package:flutter/material.dart';

import 'package:movies_app/screens/home_screen/Home_Widget/widgets/similar.dart';
import 'package:movies_app/models/general_response.dart';

import 'package:movies_app/screens/details_screen/details_widget.dart';
import 'package:movies_app/screens/details_screen/details_app_bar_widget.dart';

class DetailsScreen extends StatefulWidget {
  static const String routeName = 'details_Screen';

  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          DetailsAppBar(movie: movie),
          SliverToBoxAdapter(
              child: Column(
            children: [DetailsWidget(movie: movie), Similar(movie: movie)],
          ))
        ],
      ),
    );
  }
}
