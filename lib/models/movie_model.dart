class MovieList {
  int? page;
  int? totalMovies;
  int? totalPages;
  List<Movie>? movies;

  MovieList({this.page, this.totalMovies, this.totalPages, this.movies});

  MovieList.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalMovies = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      movies = [];
      json['results'].forEach((v) {
        movies!.add(Movie.fromJson(v));
      });
    }
  }
}

class Movie {
  int? id;
  String? overview;
  String? title;
  String? posterPath;
  String? releaseDate;
  num? voteAverage;

  Movie({
    this.id,
    this.overview,
    this.title,
    this.posterPath,
    this.releaseDate,
    this.voteAverage,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    overview = json['overview'];
    title = json['title'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    voteAverage = json['vote_average'];
  }
}

class MovieInfo {
  bool? adult;
  bool isFav = false;
  int? budget;
  List<Genres>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  String? originalLanguage;
  String? overview;
  String? posterPath;
  int? runtime;
  String? status;
  String? title;
  double? voteAverage;
  int? voteCount;
  Videos? videos;

  MovieInfo({
    this.adult,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.overview,
    this.posterPath,
    this.runtime,
    this.status,
    this.title,
    this.voteAverage,
    this.voteCount,
    this.videos,
  });

  MovieInfo.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    budget = json['budget'];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(Genres.fromJson(v));
      });
    }
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    originalLanguage = json['original_language'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    runtime = json['runtime'];
    status = json['status'];
    title = json['title'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    videos = json['videos'] != null ? Videos.fromJson(json['videos']) : null;
  }
}

class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Backdrops {
  double? aspectRatio;
  int? height;
  String? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  Backdrops({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  Backdrops.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }
}

class Videos {
  List<VideoInfo>? results;

  Videos({this.results});

  Videos.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <VideoInfo>[];
      json['results'].forEach((v) {
        results!.add(VideoInfo.fromJson(v));
      });
    }
  }
}

class VideoInfo {
  String? key;
  String? site;
  String? type;

  VideoInfo({
    this.key,
    this.site,
    this.type,
  });

  VideoInfo.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    site = json['site'];
    type = json['type'];
  }
}
