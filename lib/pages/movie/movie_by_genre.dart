import 'package:flutter/material.dart';
import 'package:flutter_application_2/helper/functions.dart';
import 'package:flutter_application_2/helper/variables.dart';
import 'package:flutter_application_2/pages/movie/moive_details.dart';
import 'package:flutter_application_2/services/movie_provider.dart';
import 'package:flutter_application_2/services/variable_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
//Custom Page build by Genric as action or comedy
class SortByGenre extends StatelessWidget {
  const SortByGenre({Key? key, required this.genreId}) : super(key: key);
  final String genreId;

  @override
  Widget build(BuildContext context) {
    return Consumer2<MovieProvider, VariableProvider>(
      builder: (_, provider, val, __) {
        provider.getGenreMovies(genreId, page: val.index);
        var movie = provider.movieListGenre?.movies;
        return movie?.isNotEmpty ?? false
            ? Scaffold(
                appBar: AppBar(),
                body: ListView(
                  controller: scrollController1,
                  children: [
                    ListView.builder(
                      controller: scrollController2,
                      itemCount: movie!.length,
                      shrinkWrap: true,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.29,
                                width:
                                    MediaQuery.of(context).size.width * 0.385,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(20),
                                  ),
                                  child: Image.network(
                                    buildMovieImage(
                                        movie[index].posterPath ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.015,
                                  left:
                                      MediaQuery.of(context).size.width * 0.035,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        : const Text(
                                            'In Production',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.55,
                                      child: Text(
                                        movie[index].overview ?? '',
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.55,
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        onPressed: () {
                                          val.flag = false;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => MovieDetails(
                                                provider: provider,
                                                movieId: movie[index].id ?? 0,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .05,
                        vertical: MediaQuery.of(context).size.height * .01,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListView.separated(
                        key: const PageStorageKey<int>(0),
                        itemCount: pageNumbers.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * .14,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .01,
                              ),
                              child: InkWell(
                                onTap: val.index != pageNumbers[index]
                                    ? () {
                                        scrollController1.animateTo(
                                            scrollController1
                                                .position.minScrollExtent,
                                            duration:
                                                const Duration(seconds: 2),
                                            curve: Curves.fastOutSlowIn);
                                        val.changeIndex(pageNumbers[index]);
                                      }
                                    : null,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Card(
                                  elevation: 5,
                                  shadowColor: Colors.grey,
                                  child: Center(
                                    child: Text(
                                      pageNumbers[index].toString(),
                                      style: TextStyle(
                                        color: val.index == pageNumbers[index]
                                            ? Colors.red
                                            : null,
                                        fontFamily: font,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                .075,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Container();
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .015,
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
