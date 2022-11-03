import 'dart:convert';
import 'package:fl_movies/models/now_playing_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '4671f57cec97ab866da2cf47c38d2cd0';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-Es';

  MoviesProvider() {
    print('Movies provider inicializado');
    getOnDisplayMovies();
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
      print(nowPlayingResponse.results[1].title);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
