import 'package:flutter/material.dart';
import 'package:movies_app/App_theme/app_theme.dart';
import 'package:movies_app/screens/home_screen/Search_Widget/search_movie_item.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/models/general_response.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
                decoration: InputDecoration(
                    hintText: "search",
                    fillColor: AppTheme.greyColor3,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          BorderSide(color: AppTheme.greyColor2, width: 1),
                    ),
                    prefixIcon: Icon(Icons.search, color: AppTheme.whiteColor),

                    // appLocalization.e_mail
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          BorderSide(color: AppTheme.greyColor2, width: 1),
                    ),
                    hintStyle: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: AppTheme.greyColor2, fontSize: 20)),
                // controller: searchController,
                maxLines: 1,
                focusNode: FocusNode(),
                onChanged: (value) {
                  searchController.text = value;
                  setState(() {});
                },
                cursorColor: AppTheme.cyanColor,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: AppTheme.whiteColor)),
            Expanded(
              child: FutureBuilder<GeneralResponse>(
                  future: ApiManager.searchMovieResponse(searchController.text),
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
                          ApiManager.searchMovieResponse(searchController.text);
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
    );
  }
}
