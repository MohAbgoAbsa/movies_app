import 'package:flutter/material.dart';
import 'package:movies_app/models/movie_detail_response.dart';
import 'package:movies_app/screens/home_screen/Browse_Widget/movies_by_category_screen.dart';

class CategoryItem extends StatelessWidget {
  Genre genre;
  bool assetExist = true;

  CategoryItem({required this.genre, super.key}) {
    assetExist = getAssetExist();
  }

  bool getAssetExist() {
    List assetList = [
      "Action",
      "Adventure",
      "Animation",
      "Comedy",
      "Crime",
      "Documentary",
      "Drama",
      "Family",
      "Fantasy",
      "History",
      "Horror",
      "Music",
      "Mystery",
      "Romance",
      "Science Fiction",
      "TV Movie",
      "Thriller",
      "War",
      "Western",
    ];
    bool exist = false;
    for (int i = 0; i < assetList.length; i++) {
      if (assetList[i] == genre.name) {
        exist = true;
        return exist;
      }
    }
    return exist;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MoviesByCategoryScreen.routeName,
            arguments: genre);
      },
      child: SizedBox(
        width: screenSize.width * .40,
        height: screenSize.height * .18,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/images/General_Movie.png",
                  width: screenSize.width * .40,
                  height: screenSize.height * .16,
                  fit: BoxFit.fill),
            ),
            Text(
              genre.name ?? "",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
