import 'package:flutter/material.dart';
import 'package:movies_app/App_theme/app_theme.dart';
import 'package:movies_app/screens/home_screen/Browse_Widget/browse_widget.dart';
import 'package:movies_app/screens/home_screen/Home_Widget/home_widget.dart';
import 'package:movies_app/screens/home_screen/Search_Widget/search_widget.dart';
import 'package:movies_app/screens/home_screen/Watch_List_Widget/watch_list_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_Screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> homeBody = const [
    HomeWidget(),
    SearchWidget(),
    BrowseWidget(),
    WatchListWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: AppTheme.bottomNavigationBackgroundColor),
        child:
          BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(
                  icon: bottomNavIcon(assetImage: "assets/images/home.png"),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: bottomNavIcon(assetImage: "assets/images/search.png"),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: bottomNavIcon(assetImage: "assets/images/browse.png"),
                  label: "Browse",
                ),
                BottomNavigationBarItem(
                  icon:
                      bottomNavIcon(assetImage: "assets/images/watch_list.png"),
                  label: "WatchList",
                ),
              ]),

      ),
      body: homeBody[selectedIndex],
    );
  }

  Padding bottomNavIcon({required String assetImage}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ImageIcon(
        AssetImage(assetImage),
      ),
    );
  }
}

