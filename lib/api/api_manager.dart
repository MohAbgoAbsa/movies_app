import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/api/api_constatnts.dart';
import 'package:movies_app/models/category_response.dart';
import 'package:movies_app/models/trailer_response.dart';
import 'package:movies_app/models/general_response.dart';
import 'package:movies_app/models/movie_detail_response.dart';

class ApiManager {
  // get categories from api
  static Future<CategoryResponse> getCategoryResponse() async {
    Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.categoriesApi, {
      "api_key": ApiConstants.api_key,
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return CategoryResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  // get popular movies from api
  static Future<GeneralResponse> getPopularMoviesResponse(String pageNo) async {
    Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.popularMovieApi,
        {"api_key": ApiConstants.api_key, "language": "en-US", "page": pageNo});
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return GeneralResponse.fromJson(json);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // get upComing movies from api
  static Future<GeneralResponse> getUpComingMoviesResponse(
      String pageNo) async {
    Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.upComingMovieApi,
        {"api_key": ApiConstants.api_key, "language": "en-US", "page": pageNo});
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return GeneralResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  // get top rated movies from api
  static Future<GeneralResponse> getTopRatedMoviesResponse(
      String pageNo) async {
    Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.topRatedMovieApi,
        {"api_key": ApiConstants.api_key, "language": "en-US", "page": pageNo});
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return GeneralResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  // get detail movie from api
  static Future<MovieDetailResponse> detailMoviesResponse(int movieId) async {
    Uri url =
        Uri.https(ApiConstants.baseurl, ApiConstants.detailMovieApi(movieId), {
      "api_key": ApiConstants.api_key,
      "language": "en-US",
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MovieDetailResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  // get similar movies from api
  static Future<GeneralResponse> getSimilarMoviesResponse(
      int movieId, String pageNo) async {
    Uri url = Uri.https(
        ApiConstants.baseurl,
        ApiConstants.similarMovieApi(movieId),
        {"api_key": ApiConstants.api_key, "language": "en-US", "page": pageNo});
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return GeneralResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  // search movies from api
  static Future<GeneralResponse> searchMovieResponse(String movieTitle) async {
    Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.searchMovieApi,
        {"api_key": ApiConstants.api_key, "query": movieTitle});
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return GeneralResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }


  static Future<GeneralResponse> discoverMovieByCategoryResponse(
      {required String pageNo, required String categoryId}) async {
    Uri url = Uri.https(
        ApiConstants.baseurl, ApiConstants.discoverMoviesByCategoryApi, {
      "api_key": ApiConstants.api_key,
      "page": pageNo,
      "with_genres": categoryId,
      "sort_by": "popularity.desc",
      "language": "en-US"
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return GeneralResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  // get detail movie from api
  static Future<TrailerResponse> youtubeMoviesResponse(int movieId) async {
    Uri url = Uri.https(
        ApiConstants.baseurl, ApiConstants.youtubeMovieApi(movieId), {
      "api_key": ApiConstants.api_key,
      "language": "en-US",
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return TrailerResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}
