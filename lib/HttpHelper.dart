import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:latihan_5/movies.dart';

class HttpHelper {
  final String _urlKey = "?api_key=25d6d05bf559e0a5e5e5655520f3b9d9";
  final String _urlBase = "https://api.themoviedb.org/3/movie";

  Future<List<Movie>> getMovies() async {
    var url = Uri.parse(_urlBase + '/now_playing' + _urlKey);
    http.Response result = await http.get(url);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List<Movie> movies = moviesMap.map<Movie>((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
