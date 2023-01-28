import 'package:flutter/material.dart';
import 'package:flutter_application_2/helper/builders.dart';
import 'package:flutter_application_2/helper/functions.dart';
import 'package:flutter_application_2/services/movie_provider.dart';
import 'package:flutter_application_2/services/variable_provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetails extends StatefulWidget {
  final MovieProvider provider;
  final int movieId;
  const MovieDetails({
    Key? key,
    required this.provider,
    required this.movieId,
  }) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late YoutubePlayerController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: widget.provider.getMovieInfo(widget.movieId),
        builder: (_, AsyncSnapshot<dynamic> snapshot) {
          var path = widget.provider;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(35),
                  ),
                  child: Consumer<VariableProvider>(
                    builder: (_, provider, __) {
                      return YoutubePlayerBuilder(
                          player: YoutubePlayer(
                            onEnded: (_) => provider.isPlaying = false,
                            controller: _controller = YoutubePlayerController(
                              initialVideoId: path.key,
                              flags: const YoutubePlayerFlags(
                                autoPlay: true,
                                enableCaption: false,
                                hideThumbnail: true,
                                hideControls: true,
                              ),
                            ),
                          ),
                          builder: (_, player) {
                            return InkWell(
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(35),
                              ),
                              onDoubleTap: () async {
                                if (!path.favoriteList.any((element) =>
                                    element.id == path.detailsMovie!.id)) {
                                  path.favoriteList.add(path.detailsMovie!);
                                }
                              },
                              onTap: () {
                                provider.switchIsPlaying();
                              },
                              child: Stack(
                                children: [
                                  provider.isPlaying != true
                                      ? Image.network(
                                          buildMovieImage(
                                            path.detailsMovie?.posterPath ?? '',
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .768,
                                          child: player,
                                        ),
                                  AppBar(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    actions: [
                                      path.detailsMovie?.status == 'Released'
                                          ? Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Icon(
                                                  Icons.star_rounded,
                                                  color: Colors.amber,
                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.145,
                                                ),
                                                Text(
                                                  '${path.detailsMovie?.voteAverage!.toStringAsFixed(1)}',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                ),
                Consumer<VariableProvider>(
                  builder: (_, val, __) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.005,
                        horizontal: MediaQuery.of(context).size.width * 0.035,
                      ),
                      child: path.detailsMovie?.status == 'Released'
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Overview',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      path.detailsMovie?.overview ?? '',
                                      maxLines: val.flag ? 8 : 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        val.changeFlag();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            val.flag ? 'Collapse' : 'Expand',
                                            style: const TextStyle(
                                              color: Colors.blue,
                                            ),
                                          ),
                                          Icon(
                                            val.flag
                                                ? Icons
                                                    .keyboard_arrow_up_rounded
                                                : Icons
                                                    .keyboard_arrow_down_rounded,
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildColumnInfo(
                                      'Duration',
                                      path.detailsMovie?.runtime ?? 0,
                                      'time',
                                    ),
                                    buildColumnInfo(
                                      'Lanuage',
                                      path.detailsMovie?.originalLanguage!
                                          .toUpperCase(),
                                      'string',
                                    ),
                                    buildColumnInfo(
                                      'Restricted',
                                      convertAdult(
                                          path.detailsMovie?.adult ?? false),
                                      'string',
                                    ),
                                    buildColumnInfo(
                                      'Budget',
                                      path.detailsMovie?.budget,
                                      'int',
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                  ),
                                  child: const Text(
                                    'Images',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount: path.movieImges.length > 15
                                        ? path.movieImges.length.clamp(0, 15)
                                        : path.movieImges.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: Image.network(
                                            buildMovieImage(
                                              path.movieImges[index].filePath ??
                                                  '',
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .025,
                                ),
                              ],
                            )
                          : buildColumnInfo(
                              'Status',
                              path.detailsMovie?.status,
                              'string',
                            ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
