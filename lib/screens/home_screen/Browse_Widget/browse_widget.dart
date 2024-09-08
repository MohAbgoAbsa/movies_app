import 'package:flutter/material.dart';
import 'package:movies_app/App_theme/app_theme.dart';
import 'package:movies_app/screens/home_screen/Browse_Widget/category_item.dart';
import 'package:movies_app/models/category_response.dart';

import 'package:movies_app/api/api_manager.dart';

class BrowseWidget extends StatefulWidget {
  const BrowseWidget({super.key});

  @override
  State<BrowseWidget> createState() => _BrowseWidgetState();
}

class _BrowseWidgetState extends State<BrowseWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(
                "Browse Category",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: FutureBuilder<CategoryResponse>(
                  future: ApiManager.getCategoryResponse(),
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
                          ApiManager.getCategoryResponse();
                          setState(() {});
                        },
                        icon: const Icon(Icons.error),
                        color: AppTheme.redColor,
                      ));
                    }
                    var categories = snapshot.data?.genres ?? [];

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        return CategoryItem(genre: categories[index]);
                      },
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: categories.length,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
