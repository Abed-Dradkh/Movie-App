import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/helper/builders.dart';
import 'package:flutter_application_2/helper/functions.dart';
import 'package:flutter_application_2/helper/variables.dart';
import 'package:flutter_application_2/models/movie_model.dart';
import 'package:flutter_application_2/pages/movie/moive_details.dart';
import 'package:flutter_application_2/pages/movie/movie_by_genre.dart';
import 'package:flutter_application_2/pages/movie/see_more.dart';
import 'package:flutter_application_2/services/movie_provider.dart';
import 'package:flutter_application_2/services/user_provider.dart';
import 'package:flutter_application_2/services/variable_provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer3<MovieProvider, VariableProvider, UserProvider>(
      builder: (_, provider, variable, user, __) {
        var cate = provider.listGenres;
        var movie = provider.popularMovies?.movies;
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.015,
                horizontal: MediaQuery.of(context).size.width * 0.035,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hi, ${user.userName.isEmpty ? controllers[0].text : user.userName}',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.065,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.height * 0.035,
                            backgroundImage: user.userPhotoUrl.isNotEmpty
                                ? FileImage(
                                    File(user.userPhotoUrl),
                                  )
                                : null,
                            child: user.userPhotoUrl.isEmpty
                                ? Image.asset(
                                    user.defualtImage,
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.035,
                    ),
                    TypeAheadField(
                      hideOnError: true,
                      hideOnEmpty: true,
                      hideOnLoading: true,
                      suggestionsCallback: provider.searchMovies,
                      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                        elevation: 0,
                      ),
                      textFieldConfiguration: TextFieldConfiguration(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      itemBuilder: (_, Movie movie) {
                        return movie.posterPath != null
                            ? Row(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              .025,
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              .01,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        buildMovieImage(movie.posterPath ?? ''),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    buildMovieName(
                                      movie.title ?? '',
                                      int.parse(
                                        (MediaQuery.of(context).size.width *
                                                .07)
                                            .toStringAsFixed(0),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container();
                      },
                      onSuggestionSelected: (Movie movie) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MovieDetails(
                              provider: provider,
                              movieId: movie.id ?? 0,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.14,
                      child: ListView.separated(
                        itemCount: cate.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                _,
                                MaterialPageRoute(
                                  builder: (_) {
                                    variable.index = 1;
                                    return SortByGenre(
                                      genreId: cate[index].id.toString(),
                                    );
                                  },
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(25),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                shadowColor: Colors.grey,
                                elevation: 3,
                                color: Colors.grey.withOpacity(0.8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/${cate[index].name?.toLowerCase() ?? ''}.png',
                                      width: MediaQuery.of(context).size.width *
                                          0.13,
                                    ),
                                    Text(
                                      cate[index].name ?? '',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                        separatorBuilder: (_, __) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Popular',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                        buildSeeMore(
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MoreMovie(path: 'any'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    movie?.isNotEmpty ?? true
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.39,
                            child: ListView.separated(
                              itemCount: movie?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((_, index) {
                                return InkWell(
                                  borderRadius: BorderRadius.circular(25),
                                  onTap: () {
                                    variable.flag = false;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => MovieDetails(
                                          provider: provider,
                                          movieId: movie?[index].id ?? 0,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.49,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.35,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          shadowColor: Colors.grey,
                                          elevation: 7,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            child:
                                                movie?[index].posterPath != null
                                                    ? Image.network(
                                                        buildMovieImage(
                                                          movie?[index]
                                                                  .posterPath ??
                                                              '',
                                                        ),
                                                        fit: BoxFit.fill,
                                                      )
                                                    : const FlutterLogo(),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        buildMovieName(
                                            movie?[index].title ?? '', 18),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              separatorBuilder: (_, __) {
                                return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                );
                              },
                            ),
                          )
                        : const CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
