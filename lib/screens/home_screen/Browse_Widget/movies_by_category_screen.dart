import 'package:flutter/material.dart';
import 'package:movies_app/App_theme/app_theme.dart';
import 'package:movies_app/screens/home_screen/Search_Widget/search_movie_item.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/models/movie_detail_response.dart';
import 'package:movies_app/models/general_response.dart';

class MoviesByCategoryScreen extends StatefulWidget {
  static const String routeName = "MoviesByCategoryScreen";

  const MoviesByCategoryScreen({super.key});

  @override
  State<MoviesByCategoryScreen> createState() => _MoviesByCategoryScreenState();
}

class _MoviesByCategoryScreenState extends State<MoviesByCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var genre = ModalRoute.of(context)?.settings.arguments as Genre;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        genre.name ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleLarge,
      )),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: FutureBuilder<GeneralResponse>(
                    future: ApiManager.discoverMovieByCategoryResponse(
                        pageNo: "1", categoryId: "${genre.id}"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                              color: AppTheme.yellowColor),
                        );
                      } else if (snapshot.hasError ||
                          snapshot.data?.success == "false") {
                        return Center(
                            child: IconButton(
                          onPressed: () {
                            ApiManager.discoverMovieByCategoryResponse(
                                pageNo: "1", categoryId: "${genre.id}");
                            setState(() {});
                          },
                          icon: const Icon(Icons.error),
                          color: AppTheme.redColor,
                        ));
                      }
                      var movieDetails = snapshot.data?.results ?? [];

                      return movieDetails.isEmpty
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
                              itemCount: movieDetails.length,
                              itemBuilder: (context, index) {
                                return SearchMovieItem(
                                    movie: movieDetails[index]);
                              },
                            );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
