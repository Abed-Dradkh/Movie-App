import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/helper/functions.dart';
import 'package:flutter_application_2/pages/movie/moive_details.dart';
import 'package:flutter_application_2/services/movie_provider.dart';
import 'package:flutter_application_2/services/variable_provider.dart';

Padding buildInput(
  BuildContext context,
  TextEditingController controller,
  String text,
) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: MediaQuery.of(context).size.height * 0.015,
    ),
    child: TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$text Is Required!';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}

InkWell buildSignMethods(BuildContext context, String path, Function function) {
  return InkWell(
    onTap: () {
      function();
    },
    borderRadius: BorderRadius.circular(50),
    child: Image.asset(
      'assets/images/$path',
      height: MediaQuery.of(context).size.height * 0.06,
    ),
  );
}

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

TextButton buildSeeMore(Function function) {
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

TextFormField buildTextFormField(
  TextEditingController controller,
  String text,
  Icon icon,
  bool? scure,
) {
  return TextFormField(
    controller: controller,
    obscureText: scure ?? false,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return '$text field is required!';
      } else {
        if (text == 'Email' && !EmailValidator.validate(value)) {
          return 'Invaild Email';
        } else {
          if (text == 'Password' && value.trim().length < 6) {
            return 'Invaild Password min: 6';
          } else {
            return null;
          }
        }
      }
    },
    decoration: InputDecoration(
      prefixIcon: icon,
      hintText: text,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}

Column buildColumnInfo(String info, var detail, String type) {
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

SizedBox buildSpace(
  BuildContext context,
  String text,
  MovieProvider path,
) {
  if (text.contains('IMDb')) {
    if (path.score.imDb != '') {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.075,
      );
    }
  } else if (text.contains('Rotten_Tomatoes')) {
    if (path.score.rottenTomatoes != '') {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.075,
      );
    }
  } else if (text.contains('Metacritic')) {
    if (path.score.metacritic != '') {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.075,
      );
    }
  } else if (text.contains('MovieDb')) {
    if (path.score.theMovieDb != '') {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.075,
      );
    }
  } else {
    if (path.score.filmAffinity != '') {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.075,
      );
    }
  }
  return const SizedBox();
}

String buildScorePath(String text, MovieProvider path) {
  if (text.contains('IMDb')) {
    if (path.score.imDb != '') {
      return '${path.score.imDb}';
    }
  } else if (text.contains('Rotten_Tomatoes')) {
    if (path.score.rottenTomatoes != '') {
      return '${path.score.rottenTomatoes}';
    }
  } else if (text.contains('Metacritic')) {
    if (path.score.metacritic != '') {
      return '${path.score.metacritic}';
    }
  } else if (text.contains('MovieDb')) {
    if (path.score.theMovieDb != '') {
      return '${path.score.theMovieDb}';
    }
  } else {
    if (path.score.filmAffinity != '') {
      return '${path.score.filmAffinity}';
    }
  }
  return '';
}

Widget buildscore(
  BuildContext context,
  String text,
  String score,
  String basedOn,
) {
  return score != ''
      ? Column(
          children: [
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            Text(
              score + basedOn,
              style: TextStyle(
                fontFamily: 'Playfair',
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.075,
              ),
            ),
          ],
        )
      : const SizedBox();
}

Widget buildListMovies(
  BuildContext context,
  MovieProvider reader,
  VariableProvider variable,
  String path,
) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.32,
    child: ListView.separated(
      itemCount: path.contains('popular')
          ? reader.popularMovies?.movies?.length ?? 0
          : path.contains('topRated')
              ? reader.topRatedMovies?.movies?.length ?? 0
              : path.contains('upComing')
                  ? reader.latestMovies?.movies?.length ?? 0
                  : reader.similarMovies?.movies?.length ?? 0,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, index) {
        var movie = path.contains('popular')
            ? reader.popularMovies?.movies
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
