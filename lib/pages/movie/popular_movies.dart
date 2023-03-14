import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/helper/functions.dart';
import 'package:flutter_application_2/pages/movie/moive_details.dart';
import 'package:flutter_application_2/services/movie_provider.dart';
import 'package:provider/provider.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (_, provider, __) {
        return Scaffold(
          backgroundColor: Colors.amber,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
          ),
          body: Column(
            children: [
              Swiper(
                itemCount: provider.popularMovies?.movies?.length ?? 0,
                layout: SwiperLayout.TINDER,
                itemHeight: MediaQuery.of(context).size.height * 0.8,
                itemWidth: MediaQuery.of(context).size.width * 1.3,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieDetails(
                            provider: provider,
                            movieId:
                                provider.popularMovies?.movies?[index].id ?? 0,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            buildMovieImage(
                              provider.popularMovies?.movies?[index]
                                      .posterPath ??
                                  '',
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
