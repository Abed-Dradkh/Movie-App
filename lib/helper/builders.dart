import 'package:flutter/material.dart';
import 'package:flutter_application_2/helper/functions.dart';
import 'package:flutter_application_2/pages/movie/moive_details.dart';
import 'package:flutter_application_2/services/movie_provider.dart';
import 'package:flutter_application_2/services/variable_provider.dart';

Widget buildRow(BuildContext context, String text, Function function) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.width * 0.05,
        ),
      ),
      TextButton(
        onPressed: () {
          function();
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: const Text('See more'),
      ),
    ],
  );
}

TextButton buildSeeMore(Function function) { //building seeMore button with same senario
  return TextButton(
    onPressed: () {
      function();
    },
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    ),
    child: const Text('See more'),
  );
}

Column buildColumnInfo( //build view of exploring
  String info,
  var detail,
  String type,
) {
  return Column(
    children: [
      Text(
        info,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.amber,
        ),
      ),
      type.contains('string')
          ? Text(detail)
          : type.contains('time')
              ? Text(
                  convertTime(detail ?? 0),
                )
              : Text(
                  convertBudget(detail),
                ),
    ],
  );
}

Widget buildListMovies( //build list of movies with design 
  BuildContext context,
  MovieProvider reader,
  VariableProvider variable,
  String path,
) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.32,
    child: ListView.separated(
      itemCount: path.contains('popular')
          ? reader.dioPopular?.movies?.length ?? 0
          : path.contains('topRated')
              ? reader.topRatedMovies?.movies?.length ?? 0
              : path.contains('upComing')
                  ? reader.latestMovies?.movies?.length ?? 0
                  : reader.similarMovies?.movies?.length ?? 0,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, index) {
        var movie = path.contains('popular')
            ? reader.dioPopular?.movies
            : path.contains('topRated')
                ? reader.topRatedMovies?.movies
                : path.contains('upComing')
                    ? reader.latestMovies?.movies
                    : reader.similarMovies?.movies;
        return InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            variable.flag = false;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MovieDetails(
                  provider: reader,
                  movieId: movie?[index].id ?? 0,
                ),
              ),
            );
          },
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.41,
                height: MediaQuery.of(context).size.height * 0.28,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  shadowColor: Colors.grey,
                  elevation: 7,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: movie?[index].posterPath != null
                        ? Image.network(
                            buildMovieImage(
                              movie?[index].posterPath ?? '',
                            ),
                            fit: BoxFit.fill,
                          )
                        : const FlutterLogo(),
                  ),
                ),
              ),
              Text(
                buildMovieName(movie?[index].title ?? '', 18),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.02,
        );
      },
    ),
  );
}
