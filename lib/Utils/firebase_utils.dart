import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Utils/dialog_utils.dart';
import 'package:movies_app/models/general_response.dart';

class FirebaseUtils {
  // get movies collection reference
  static CollectionReference<Movie> getMoviesCollection() {
    return FirebaseFirestore.instance
        .collection("watch_list")
        .withConverter<Movie>(
            fromFirestore: (snapshot, _) => Movie.fromJson(snapshot.data()!),
            toFirestore: (movie, _) => movie.toJson());
  }

  // add movie object to firestore
  static Future addMovieToFirestore(Movie movie, BuildContext context) async {
    DialogUtils.showLoading(
        context: context, loadingMessage: "Adding to watch list.....");
    await Future.delayed(const Duration(seconds: 2));

    try {
      CollectionReference<Movie> movieCollection = getMoviesCollection();
      DocumentReference<Movie> docRef = movieCollection.doc("${movie.id}");
      docRef.set(movie);

      DialogUtils.hideLoading(context);

      DialogUtils.showMessage(
          context: context,
          content: "Movie added to watch List.",
          title: "Success",
          posActions: "ok");
    } catch (e) {
      DialogUtils.hideLoading(context);

      DialogUtils.showMessage(
          context: context,
          content: e.toString(),
          title: "Error",
          negActions: "ok");
    }
  }

  // delete movie object from firestore

  static Future<void> deleteMovieFromFirebase(
      Movie movie, BuildContext context) async {
    DialogUtils.showLoading(
        context: context, loadingMessage: "Removing from watch list....");
    await Future.delayed(const Duration(seconds: 2));

    try {
      DialogUtils.hideLoading(context);

      getMoviesCollection().doc("${movie.id}").delete();

      DialogUtils.showMessage(
          context: context,
          content: "Movie deleted from watch List.",
          title: "Success",
          posActions: "ok");
    } catch (e) {
      DialogUtils.hideLoading(context);

      DialogUtils.showMessage(
          context: context,
          content: e.toString(),
          title: "Error",
          posActions: "ok");
    }
  }

  static Stream<QuerySnapshot<Movie>> readMovieFromFirestore() {
    var querySnapshot = getMoviesCollection().snapshots();
    return querySnapshot;
  }

  static Future<bool> existMovieInFirestore(Movie movie) async {
    var querySnapshot = await getMoviesCollection().doc("${movie.id}").get();
    return querySnapshot.exists;
  }
}
