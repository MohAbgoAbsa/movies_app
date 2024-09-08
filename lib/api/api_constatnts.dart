class ApiConstants {
  static const String baseurl = "api.themoviedb.org";
  static const String api_key = "2a8399b38be185e1cb3b6fd3a9f86c5a";

  static const String categoriesApi = "/3/genre/movie/list";
  static const String popularMovieApi = "/3/movie/popular";
  static const String upComingMovieApi = "/3/movie/upcoming";
  static const String topRatedMovieApi = "/3/movie/top_rated";
  static const String youtubeBaseurl = "https://www.youtube.com/watch?v=";

  static String detailMovieApi(int movieId) {
    return "/3/movie/$movieId";
  }

  static const String searchMovieApi = "/3/search/movie";

  static String similarMovieApi(int movieId) {
    return "/3/movie/$movieId/similar";
  }

  static String youtubeMovieApi(int movieId) {
    return "/3/movie/$movieId/videos";
  }

  static const String discoverMoviesByCategoryApi = "3/discover/movie";

  static const String baseImageUrl = "https://image.tmdb.org/t/p/w500";
}
