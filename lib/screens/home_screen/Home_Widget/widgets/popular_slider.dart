import 'package:flutter/material.dart';
import 'package:movies_app/App_theme/app_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies_app/models/general_response.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/screens/home_screen/Home_Widget/widgets/movie_item.dart';

class PopularSlider extends StatefulWidget {
  const PopularSlider({
    super.key,
  });

  @override
  State<PopularSlider> createState() => _PopularSliderState();
}

class _PopularSliderState extends State<PopularSlider> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: screenSize.height * .30,
      child: FutureBuilder<GeneralResponse>(
          future: ApiManager.getPopularMoviesResponse("1"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: AppTheme.yellowColor,),
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
                        ApiManager.getPopularMoviesResponse("1");
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
                        ApiManager.getPopularMoviesResponse("1");
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
            return CarouselSlider.builder(
                itemCount: results?.length,
                itemBuilder: (context, index, realIndex) {
                  return MovieItem(
                    iconSize: 70,
                    height: screenSize.height * .65,
                    width: screenSize.width,
                    movie: results?[index],
                    onPressedBookmarkIcon: onPressedBookmarkIcon,
                  );
                },
                options: CarouselOptions(

                    height: screenSize.height * .3,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,

                  scrollDirection: Axis.horizontal,
                ));
          }),
    );
  }

  onPressedBookmarkIcon(Movie movie) {

  }
}
