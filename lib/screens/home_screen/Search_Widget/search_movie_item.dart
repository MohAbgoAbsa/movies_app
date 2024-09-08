
import 'package:flutter/material.dart';
import 'package:movies_app/App_theme/app_theme.dart';
import 'package:movies_app/screens/details_screen/detail_movie_screen.dart';
import 'package:movies_app/api/api_constatnts.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/Utils/methods.dart';
import 'package:movies_app/models/movie_detail_response.dart';
import 'package:movies_app/models/general_response.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchMovieItem extends StatefulWidget {
  final Movie? movie;

  const SearchMovieItem({required this.movie, super.key});

  @override
  State<SearchMovieItem> createState() => _SearchMovieItemState();
}

class _SearchMovieItemState extends State<SearchMovieItem> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(DetailsScreen.routeName, arguments: widget.movie);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: AppTheme.greyColor2),
        )),
        width: double.infinity,
        height: screenSize.height * .15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width * .4,
                  height: MediaQuery.of(context).size.height * .15,
                  fit: BoxFit.fill,
                  imageUrl:
                      "${ApiConstants.baseImageUrl}${widget.movie?.posterPath}",
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.yellowColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: AppTheme.redColor,
                  ),
                ),
              ),
            ),
            FutureBuilder<MovieDetailResponse>(
                future: ApiManager.detailMoviesResponse(widget.movie?.id ?? 0),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child:
                          CircularProgressIndicator(color: AppTheme.yellowColor),
                    );
                  } else if (snapshot.hasError ||
                      snapshot.data?.success == "false") {
                    return Center(
                        child: IconButton(
                      onPressed: () {
                        ApiManager.detailMoviesResponse(widget.movie?.id ?? 0);
                        setState(() {});
                      },
                      icon: const Icon(Icons.error),
                      color: AppTheme.redColor,
                    ));
                  }
                  var movieDetails = snapshot.data;

                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          movieDetails?.title ?? "",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                        ),
                        Text(
                          MyMethods.yearFromString(movieDetails?.releaseDate),
                          textAlign: TextAlign.left,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  fontSize: 11, fontWeight: FontWeight.normal),
                        ),
                        Text(
                          movieDetails?.tagline ?? "",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  fontSize: 10, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
