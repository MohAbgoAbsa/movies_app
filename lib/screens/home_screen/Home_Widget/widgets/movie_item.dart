
import 'package:flutter/material.dart';
import 'package:movies_app/App_theme/app_theme.dart';
import 'package:movies_app/Utils/firebase_utils.dart';

import 'package:movies_app/api/api_constatnts.dart';
import 'package:movies_app/Utils/methods.dart';
import 'package:movies_app/models/general_response.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/screens/details_screen/detail_movie_screen.dart';
import 'package:movies_app/models/movie_detail_response.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieItem extends StatefulWidget {
  final Movie? movie;
  final Function onPressedBookmarkIcon;
  final double height;
  final double width;
  final double iconSize;
  final bool withBottomDetail;
  final bool tappable;
  const MovieItem(
      {super.key,
      required this.movie,
      required this.height,
      required this.width,
      required this.iconSize,
      this.withBottomDetail = false,
      this.tappable = true,
      required this.onPressedBookmarkIcon});



  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  Color iconColor = AppTheme.greyColor.withOpacity(.70);
  IconData? icon = Icons.add;

  checkinWatchList() async {
    if (await FirebaseUtils.existMovieInFirestore(widget.movie!)) {
      icon = Icons.check;
      iconColor = AppTheme.yellowColor.withOpacity(.70);
    } else {
      icon = Icons.add;
      iconColor = AppTheme.greyColor.withOpacity(.70);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkinWatchList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.tappable) {
          Navigator.of(context)
              .pushNamed(DetailsScreen.routeName, arguments: widget.movie);
        }
      },
      child: Container(
          margin: const EdgeInsets.all(5),
          height: widget.height,
          width: widget.width,
          child: FutureBuilder<MovieDetailResponse>(
            future: ApiManager.detailMoviesResponse(widget.movie?.id ?? 0),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: AppTheme.yellowColor),
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

              return Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CachedNetworkImage(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .65,
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
                Positioned(
                  top: 0,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      widget.onPressedBookmarkIcon(widget.movie);
                      if (icon == Icons.add) {
                        FirebaseUtils.addMovieToFirestore(
                            widget.movie!, context);
                        icon = Icons.check;
                        iconColor = AppTheme.yellowColor.withOpacity(.70);
                      } else {
                        FirebaseUtils.deleteMovieFromFirebase(
                            widget.movie!, context);

                        icon = Icons.add;
                        iconColor = AppTheme.greyColor.withOpacity(.70);
                      }
                      setState(() {});
                    },
                    child: Stack(children: [
                      Icon(
                        Icons.bookmark_rounded,
                        size: widget.iconSize,
                        color: iconColor,
                      ),
                      Positioned(
                          right: 0,
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Icon(
                            icon,
                            color: AppTheme.whiteColor,
                          ))
                    ]),
                  ),
                ),
                widget.withBottomDetail
                    ? Positioned(
                        bottom: 0,
                        child: Container(
                          height: widget.height * .25,
                          width: widget.width,
                          color: Theme.of(context).cardColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5, top: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.star,
                                        color: AppTheme.yellowColor,
                                        size: 20,
                                      ),
                                    ),
                                    Text(
                                      MyMethods.roundDecimalNo(
                                          widget.movie?.voteAverage, 1),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5.0),
                                child: Text(
                                  widget.movie?.originalTitle ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        MyMethods.yearFromString(
                                            widget.movie?.releaseDate),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        movieDetails?.status?[0] ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        MyMethods.getTimeString(
                                            movieDetails!.runtime ?? 0),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink()
              ]);
            },
          )),
    );
  }
}
