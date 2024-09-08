import 'package:flutter/material.dart';
import 'package:movies_app/App_theme/app_theme.dart';
import 'package:movies_app/screens/home_screen/Home_Widget/widgets/movie_item.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/models/general_response.dart';

class Recommended extends StatefulWidget {
  const Recommended({super.key});

  @override
  State<Recommended> createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      height: screenSize.height * .3,
      width: double.infinity,
      color: AppTheme.greyColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recommended",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          FutureBuilder<GeneralResponse>(
              future: ApiManager.getTopRatedMoviesResponse("1"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child:
                        CircularProgressIndicator(color: AppTheme.yellowColor),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Something went wrong!",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ApiManager.getTopRatedMoviesResponse("1");
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor),
                          child: Text(
                            "Try again",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        )
                      ],
                    ),
                  );
                } else if (snapshot.data?.success == "false") {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.data?.statusMessage ?? "",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ApiManager.getTopRatedMoviesResponse("1");
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor),
                          child: Text(
                            "Try again",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        )
                      ],
                    ),
                  );
                }

                var results = snapshot.data?.results;

                // List<Movie>? movies = snapshot.data?.results;
                return Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: results?.length,
                      itemBuilder: (context, index) {
                        return MovieItem(
                          iconSize: 45,
                          width: screenSize.width * .40,
                          height: screenSize.height * .35,
                          movie: results?[index],
                          withBottomDetail: true,
                          onPressedBookmarkIcon: onPressedBookmarkIcon,
                        );
                      },
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  onPressedBookmarkIcon(Movie movie) {
    // loading

    // add to firestore

    // toast message
  }
}
