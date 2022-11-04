import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '4671f57cec97ab866da2cf47c38d2cd0';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-Es';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _popularPage = 0;

  MoviesProvider() {
    print('Movies provider inicializado');
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    try {
      final url = Uri.https(_baseUrl, endpoint, {
        'api_key': _apiKey,
        'language': _language,
        'page': '$page',
      });

      // Await the http get response, then decode the json-formatted response.
      final response = await http.get(url);
      return response.body;
    } catch (e) {
      print('Request failed with status: ${e.toString()}.');
      return e.toString();
    }
  }

  getOnDisplayMovies() async {
    final data = await _getJsonData('/3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(data);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final data = await _getJsonData('/3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(data);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }
}
