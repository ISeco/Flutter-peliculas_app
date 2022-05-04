import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:peliculas_app/helpers/debouncer.dart';

import 'package:peliculas_app/models/models.dart';

class MoviesProvider extends ChangeNotifier{

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = dotenv.env['API_KEY'] as String;
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int,List<CastMovie>> movieCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;

  MoviesProvider() {
    print('MoviesProvider inicializado');

    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData( String endpoint, [int page = 1, String query = ''] ) async {
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
      'query': query
    });
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final response = await _getJsonData('/3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(response);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final response = await _getJsonData('/3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(response);
    popularMovies = [ ...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<CastMovie>> getMovieCast( int movieId ) async {
    
    if ( movieCast.containsKey(movieId) ) {
      return movieCast[movieId]!;
    }

    final response = await _getJsonData('/3/movie/$movieId/credits');
    final castResponse = CastMovieResponse.fromJson(response);
    movieCast[movieId]= castResponse.cast;

    return castResponse.cast;

  }

  Future<List<Movie>> searchMovie( String query ) async {
    if ( query.isEmpty ) {
      return [];
    }
    final response = await _getJsonData('/3/search/movie', 1, query);
    final searchMovieResponse = SearchMovieResponse.fromJson(response);

    return searchMovieResponse.results;
  }

  void getSuggestionsByQuery( String query ) {
    debouncer.value = '';

    debouncer.onValue = (value) async {

      // print('Tenemos valor a buscar : $value');
      final results = await searchMovie(value);
      _suggestionStreamController.add(results);

    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(const Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}