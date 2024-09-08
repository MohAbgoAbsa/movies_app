

import 'package:flutter/material.dart';
import 'package:movies_app/screens/home_screen/home_screen.dart';
import 'package:movies_app/App_theme/app_theme.dart';
import 'package:movies_app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/screens/home_screen/Browse_Widget/movies_by_category_screen.dart';
import 'package:movies_app/screens/details_screen/detail_movie_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.disableNetwork();
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        DetailsScreen.routeName: (context) => const DetailsScreen(),
        MoviesByCategoryScreen.routeName: (context) => const MoviesByCategoryScreen()
      },

      theme: AppTheme.lightTheme,
    );
  }
}
