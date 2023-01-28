import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/helper/functions.dart';
import 'package:flutter_application_2/helper/variables.dart';
import 'package:flutter_application_2/pages/movie/moive_details.dart';
import 'package:flutter_application_2/services/movie_provider.dart';
import 'package:flutter_application_2/services/theme_provider.dart';
import 'package:flutter_application_2/services/user_provider.dart';
import 'package:flutter_application_2/services/variable_provider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer4<ThemeProvider, VariableProvider, UserProvider,
        MovieProvider>(
      builder: ((_, theme, variable, user, movie, __) {
        return Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .05,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height * .025,
                  right: MediaQuery.of(context).size.width * .01,
                  child: FlutterSwitch(
                    showOnOff: true,
                    activeText: 'Light',
                    inactiveText: 'Dark',
                    width: MediaQuery.of(context).size.width * .21,
                    activeIcon: const Icon(
                      Icons.nightlight_rounded,
                      color: Colors.black,
                    ),
                    inactiveIcon: const Icon(
                      Icons.wb_sunny_rounded,
                      color: Colors.amber,
                    ),
                    value: theme.darkTheme,
                    onToggle: (value) {
                      theme.setdarktheme(value);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .25,
                          width: MediaQuery.of(context).size.width * .5,
                          child: user.userPhotoUrl.isEmpty
                              ? Image.asset(
                                  user.defualtImage,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(user.userPhotoUrl),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      Text(
                        user.userName,
                        style: TextStyle(
                          fontFamily: font,
                          fontSize: MediaQuery.of(context).size.width * .085,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .025,
                      ),
                      Row(
                        children: [
                          Text(
                            'Favorite',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ],
                      ),
                      movie.favoriteList.isNotEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.31,
                              child: ListView.separated(
                                itemCount: movie.favoriteList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, index) {
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(25),
                                    onTap: () {
                                      variable.flag = false;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => MovieDetails(
                                            provider: movie,
                                            movieId:
                                                movie.favoriteList[index].id ??
                                                    0,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.41,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.28,
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
                                              child: movie.favoriteList[index]
                                                          .posterPath !=
                                                      null
                                                  ? Image.network(
                                                      buildMovieImage(
                                                        movie
                                                                .favoriteList[
                                                                    index]
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
                                              movie.favoriteList[index].title ??
                                                  '',
                                              18),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  );
                                },
                              ),
                            )
                          : Text(
                              'Double tap on movie to add it here!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: font,
                                fontSize:
                                    MediaQuery.of(context).size.width * .065,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
