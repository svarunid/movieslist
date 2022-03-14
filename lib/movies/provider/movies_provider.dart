import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import '../model/movie.dart';

class Movies extends StateNotifier<List<Movie>> {
  Movies() : super([]) {
    getMovies();
  }

  Future<void> getMovies() async {
    String url = 'https://hoblist.com/api/movieList';
    Map<String, String> body = {
      "category": "movies",
      "language": "kannada",
      "genre": "all",
      "sort": "voting",
    };
    final response = await http.post(Uri.parse(url), body: body);
    final List responseJSON = jsonDecode(response.body)['result'];
    state = List.generate(
      responseJSON.length,
      (index) => Movie.fromJson(responseJSON[index]),
    );
  }
}

final moviesProvider =
    StateNotifierProvider<Movies, List<Movie>>(((ref) => Movies()));
