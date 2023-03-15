import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/helper/variables.dart';
import 'package:flutter_application_2/models/movie_model.dart';
import 'package:flutter_application_2/models/scores_model.dart';
import 'package:http/http.dart' as http;

class MovieProvider extends ChangeNotifier {
  MovieProvider() {
    getLatestMovies();
    getGenreList();
    getPopularMovies();
    getTopRatedMovies();
    dioPopularMovies(); Using dio to fetch data from Api
  }

  MovieInfo? detailsMovie;
  MovieList? latestMovies;
  MovieList? popularMovies;
  MovieList? dioPopular; // using dio for request
  MovieList? similarMovies;
  MovieList? topRatedMovies;
  MovieList? movieListGenre;
  MovieList? searchMovie;
  Scores score = Scores();
  List<Genres> listGenres = [];
  List<Backdrops> movieImges = [];
  List<MovieInfo> favoriteList = [];
  String key = '';

  Future<void> getGenreList() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/genre/movie/list?api_key=$movieApi'));
    List<dynamic> body = jsonDecode(response.body)['genres'];
    listGenres = body.map((dynamic item) => Genres.fromJson(item)).toList();
    notifyListeners();
  }

  Future<void> getPopularMovies({int? page}) async {
    var response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=$movieApi&${page ?? 1}'));
    var jsonString = jsonDecode(response.body);
    popularMovies = MovieList.fromJson(jsonString);
    notifyListeners();
  }

  Future<void> dioPopularMovies({int? page}) async {
    //make request using dio
    Response response = await dio.get(
        'https://api.themoviedb.org/3/movie/popular?api_key=$movieApi&${page ?? 1}');
    dioPopular = MovieList.fromJson(response.data);
    notifyListeners();
  }

  Future<void> getTopRatedMovies() async {
    var response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$movieApi'));

    var jsonString = jsonDecode(response.body);
    topRatedMovies = MovieList.fromJson(jsonString);
    notifyListeners();
  }

  Future<void> getLatestMovies() async {
    var response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=$movieApi'));

    var jsonString = jsonDecode(response.body);
    latestMovies = MovieList.fromJson(jsonString);
    notifyListeners();
  }

  Future<void> getSimilarMovies({int? id}) async {
    var response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/similar?api_key=$movieApi',
      ),
    );

    var jsonString = jsonDecode(response.body);
    similarMovies = MovieList.fromJson(jsonString);
    notifyListeners();
  }

  Future<void> getGenreMovies(String genre, {int? page}) async {
    var response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/discover/movie?api_key=$movieApi&with_genres=$genre&page=${page ?? 1}'),
    );
    var jsonString = jsonDecode(response.body);
    movieListGenre = MovieList.fromJson(jsonString);
    notifyListeners();
  }

  Future<void> getMovieInfo(int id) async {
    var info = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=$movieApi&append_to_response=videos'));

    var jsonBody = jsonDecode(info.body);
    detailsMovie = MovieInfo.fromJson(jsonBody);

    for (var i = 0; i < detailsMovie!.videos!.results!.length; i++) {
      if (detailsMovie!.videos!.results![i].type == 'Trailer') {
        key = detailsMovie!.videos!.results![i].key ?? '';
      }
    }

    await _getImages(id);

    notifyListeners();
  }

  Future<void> _getImages(int id) async {
    var images = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/images?api_key=$movieApi'));
    List<dynamic> responseBody = jsonDecode(images.body)['backdrops'];
    movieImges =
        responseBody.map((dynamic item) => Backdrops.fromJson(item)).toList();
  }

  Future<List<Movie>> searchMovies(String movieName) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$movieApi&query=$movieName'));
    final List movies = jsonDecode(response.body)['results'];
    return movies.map((e) => Movie.fromJson(e)).toList();
  }
}
