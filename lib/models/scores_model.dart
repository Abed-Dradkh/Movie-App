class Scores {
  String? imDb;
  String? metacritic;
  String? theMovieDb;
  String? rottenTomatoes;
  String? filmAffinity;

  Scores({
    this.imDb,
    this.metacritic,
    this.theMovieDb,
    this.rottenTomatoes,
    this.filmAffinity,
  });

  Scores.fromJson(Map<String, dynamic> json) {
    imDb = json['imDb'];
    metacritic = json['metacritic'];
    theMovieDb = json['theMovieDb'];
    rottenTomatoes = json['rottenTomatoes'];
    filmAffinity = json['filmAffinity'];
  }
}
