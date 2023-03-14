import 'package:intl/intl.dart';

String buildMovieImage(String path) {
  String url = 'https://image.tmdb.org/t/p/w500/$path';
  return url;
}

String buildMovieName(String text, int num) {
  String txt = '';
  text.length > num ? txt = '${text.substring(0, num)}...' : txt = text;
  return txt;
}

String convertTime(int time) {
  var d = Duration(minutes: time);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
}

String convertAdult(bool adult) {
  var bigBoys = '';
  adult == true ? bigBoys = 'Yes' : bigBoys = 'No';
  return bigBoys;
}

String convertBudget(int budget) {
  var number =
      NumberFormat.compactCurrency(locale: 'en', decimalDigits: 0, symbol: '\$')
          .format(budget);
  return number;
}
