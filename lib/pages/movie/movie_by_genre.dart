import 'package:flutter/material.dart';
import 'package:flutter_application_2/helper/functions.dart';
import 'package:flutter_application_2/pages/movie/moive_details.dart';
import 'package:flutter_application_2/services/movie_provider.dart';
import 'package:flutter_application_2/services/variable_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SortByGenre extends StatelessWidget {
  SortByGenre({Key? key, required this.genreId}) : super(key: key);
  final _controller = ScrollController();
  final String genreId;

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (_, provider, __) {
        provider.getGenreMovies(genreId);
        var movie = provider.movieListGenre?.movies;
        return movie?.isNotEmpty ?? false
            ? Scaffold(
                appBar: AppBar(),
                body: ListView.builder(
                  controller: _controller,
                  itemCount: movie!.length,
                  itemBuilder: (_, index) {
                    var now =
                        DateTime.tryParse(movie[index].releaseDate ?? '');
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.254,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(20),
                              ),
                              child: Image.network(
                                buildMovieImage(
                                    movie[index].posterPath ?? ''),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height *
                                  0.015,
                              left: MediaQuery.of(context).size.width *
                                  0.035,
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  buildMovieName(
                                    movie[index].title ?? '',
                                    25,
                                  ),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                movie[index].releaseDate!.isEmpty
                                    ? const Text('In Production')
                                    : Text(
                                        DateFormat.yMMMMd().format(now!),
                                      ),
                                movie[index].voteAverage != 0.0
                                    ? Row(
                                        children: [
                                          const Icon(
                                            Icons.star_rounded,
                                            color: Colors.amber,
                                          ),
                                          Text(movie[index]
                                              .voteAverage!
                                              .toDouble()
                                              .toString()),
                                        ],
                                      )
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.045,
                                        ),
                                      ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width *
                                          0.55,
                                  child: Text(
                                    movie[index].overview ?? '',
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Consumer<VariableProvider>(
                                  builder: (_, val, __) {
                                    return Container(
                                      width: MediaQuery.of(context)
                                              .size
                                              .width *
                                          0.55,
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        onPressed: () {
                                          val.flag = false;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  MovieDetails(
                                                provider: provider,
                                                movieId:
                                                    movie[index].id ?? 0,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons
                                              .keyboard_arrow_right_rounded,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
