import 'package:flutter/material.dart';
import 'package:flutter_application_2/helper/builders.dart';
import 'package:flutter_application_2/services/movie_provider.dart';
import 'package:flutter_application_2/services/variable_provider.dart';
import 'package:provider/provider.dart';

class Explore extends StatelessWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<MovieProvider, VariableProvider>(
      builder: (_, reader, variable, __) {
        return Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildRow(context, 'UpComing', () {}),
                buildListMovies(context, reader, variable, 'upComing'),
                buildRow(context, 'Top Rated', () {}),
                buildListMovies(context, reader, variable, 'topRated'),
              ],
            ),
          ),
        );
      },
    );
  }
}
