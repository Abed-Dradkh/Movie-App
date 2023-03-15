import 'package:intl/intl.dart';
//All func has 1 job to do only
String buildMovieImage(String path) { //func to handle image from Api
  String url = 'https://image.tmdb.org/t/p/w500/$path';
  return url;
}

String buildMovieName(String text, int num) { //func to deal with movieName length
  String txt = '';
  text.length > num ? txt = '${text.substring(0, num)}...' : txt = text;
  return txt;
}

String convertTime(int time) { //func to handle time as I want
  var d = Duration(minutes: time);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
}

String convertAdult(bool adult) { //func to handle data isAdult and change it to yes or no
  var bigBoys = '';
  adult == true ? bigBoys = 'Yes' : bigBoys = 'No';
  return bigBoys;
}

String convertBudget(int budget) { //func to convert budget in a way we understand
  var number =
      NumberFormat.compactCurrency(locale: 'en', decimalDigits: 0, symbol: '\$')
          .format(budget);
  return number;
}
