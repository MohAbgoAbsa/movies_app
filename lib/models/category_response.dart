import 'package:movies_app/models/movie_detail_response.dart';

class CategoryResponse {
  CategoryResponse({
    this.genres,
  });

  CategoryResponse.fromJson(dynamic json) {
    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((v) {
        genres?.add(Genre.fromJson(v));
      });
    }
  }

  List<Genre>? genres;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (genres != null) {
      map['genres'] = genres?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
