
import 'package:flutter/material.dart';
import 'package:movies_app/App_theme/app_theme.dart';
import 'package:movies_app/api/api_constatnts.dart';
import 'package:movies_app/models/general_response.dart';
import 'package:movies_app/api/api_manager.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:movies_app/models/trailer_response.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailsAppBar extends StatefulWidget {
  final Movie? movie;

  const DetailsAppBar({required this.movie, super.key});

  @override
  State<DetailsAppBar> createState() => _DetailsAppBarState();
}

class _DetailsAppBarState extends State<DetailsAppBar> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SliverAppBar.large(
      leading: Container(
        margin: const EdgeInsets.only(top: 20, left: 20),
        width: screenSize.width * .1,
        height: screenSize.height * .02,
        decoration: BoxDecoration(
            color: AppTheme.blackColor, borderRadius: BorderRadius.circular(10)),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:  Icon(Icons.arrow_back,color: AppTheme.whiteColor),
        ),
      ),
      expandedHeight: screenSize.height * .5,
      backgroundColor: AppTheme.blackColor,
      flexibleSpace: FlexibleSpaceBar(
        background: FutureBuilder<TrailerResponse>(
          future: ApiManager.youtubeMoviesResponse(widget.movie?.id ?? 0),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: AppTheme.yellowColor),
              );
            } else if (snapshot.hasError || snapshot.data?.success == "false") {
              return Center(
                  child: IconButton(
                onPressed: () {
                  ApiManager.youtubeMoviesResponse(widget.movie?.id ?? 0);
                  setState(() {});
                },
                icon: Icon(
                  Icons.restart_alt_rounded,
                  size: 100,
                  color: AppTheme.whiteColor.withOpacity(.5),
                ),
              ));
            }
            var results = snapshot.data?.results ?? [];
            var trailerIndex = 0;

            if (results.isNotEmpty) {
              for (int i = 0; i <= results.length - 1; i++) {
                if (results[i].type == "Trailer") {
                  trailerIndex = i;
                }
              }
            }
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  child: CachedNetworkImage(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .65,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                    imageUrl:
                        "${ApiConstants.baseImageUrl}${widget.movie?.backdropPath}",
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
                results.isNotEmpty
                    ? Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: IconButton(
                            onPressed: () {
                              launchTrailer(results[trailerIndex].key ?? "");
                            },
                            icon: Icon(
                              Icons.play_circle,
                              size: 100,
                              color: AppTheme.whiteColor.withOpacity(.8),
                            )))
                    : const SizedBox.shrink()
              ],
            );
          },
        ),
        // centerTitle: true,
        title: Text(
          widget.movie?.title ?? "",
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      pinned: true,
      floating: true,
    );
  }

  Future<void> launchTrailer(String viderUrl) async {
    Uri url = Uri.parse("${ApiConstants.youtubeBaseurl}$viderUrl");
    await launchUrl(url);
  }
}
