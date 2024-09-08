
import 'package:flutter/material.dart';
import 'package:movies_app/App_theme/app_theme.dart';
import 'package:movies_app/Utils/firebase_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/models/general_response.dart';
import 'package:movies_app/screens/home_screen/Search_Widget/search_movie_item.dart';

class WatchListWidget extends StatefulWidget {
  const WatchListWidget({super.key});

  @override
  State<WatchListWidget> createState() => _WatchListWidgetState();
}

class _WatchListWidgetState extends State<WatchListWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Watch List",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Movie>>(
                  stream: FirebaseUtils.readMovieFromFirestore(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                            color: AppTheme.yellowColor),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                          child: IconButton(
                        onPressed: () {
                          FirebaseUtils.readMovieFromFirestore();
                          setState(() {});
                        },
                        icon: const Icon(Icons.error),
                        color: AppTheme.redColor,
                      ));
                    }
                    var moviesnapshot = snapshot.data?.docs;
                    var movieList = moviesnapshot?.map((movie) {
                      return movie.data();
                    }).toList();

                    return movieList!.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                  "assets/images/movies_search_icon.png")
                            ],
                          )
                        : ListView.builder(
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: movieList.length,
                            itemBuilder: (context, index) {
                              return SearchMovieItem(movie: movieList[index]);
                            },
                          );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
