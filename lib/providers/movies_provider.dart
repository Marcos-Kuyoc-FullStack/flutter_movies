import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '4671f57cec97ab866da2cf47c38d2cd0';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-Es';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    print('Movies provider inicializado');
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    final url = Uri.https(_baseUrl, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  getPopularMovies() async {
    final url = Uri.https(_baseUrl, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final popularResponse = PopularResponse.fromJson(response.body);
      popularMovies = [...popularMovies, ...popularResponse.results];
      notifyListeners();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
