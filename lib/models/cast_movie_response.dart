// To parse this JSON data, do
//
//     final castMovieResponse = castMovieResponseFromMap(jsonString);

import 'dart:convert';

class CastMovieResponse {
    CastMovieResponse({
        required this.id,
        required this.cast,
        required this.crew,
    });

    int id;
    List<CastMovie> cast;
    List<CastMovie> crew;

    factory CastMovieResponse.fromJson(String str) => CastMovieResponse.fromMap(json.decode(str));

    factory CastMovieResponse.fromMap(Map<String, dynamic> json) => CastMovieResponse(
        id: json["id"],
        cast: List<CastMovie>.from(json["cast"].map((x) => CastMovie.fromMap(x))),
        crew: List<CastMovie>.from(json["crew"].map((x) => CastMovie.fromMap(x))),
    );
}


class CastMovie {
    CastMovie({
        required this.adult,
        required this.gender,
        required this.id,
        this.knownForDepartment,
        required this.name,
        required this.originalName,
        required this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        required this.creditId,
        this.order,
        this.department,
        this.job,
    });

    bool adult;
    int gender;
    int id;
    String? knownForDepartment;
    String name;
    String originalName;
    double popularity;
    String? profilePath;
    int? castId;
    String? character;
    String creditId;
    int? order;
    String? department;
    String? job;

    get fullProfilePath {

      if(profilePath != null) {
        return 'https://image.tmdb.org/t/p/w500$profilePath';
      }
      return 'https://i.stack.imgur.com/GNhxO.png';
    }

    factory CastMovie.fromJson(String str) => CastMovie.fromMap(json.decode(str));

    factory CastMovie.fromMap(Map<String, dynamic> json) => CastMovie(
      adult: json["adult"],
      gender: json["gender"],
      id: json["id"],
      knownForDepartment: json["known_for_department"] == null ? null : json["known_for_department"],
      name: json["name"],
      originalName: json["original_name"],
      popularity: json["popularity"].toDouble(),
      profilePath: json["profile_path"] == null ? null : json["profile_path"],
      castId: json["cast_id"] == null ? null : json["cast_id"],
      character: json["character"] == null ? null : json["character"],
      creditId: json["credit_id"],
      order: json["order"] == null ? null : json["order"],
      department: json["department"] == null ? null : json["department"],
      job: json["job"] == null ? null : json["job"],
    );
}