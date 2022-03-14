import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class Movies extends StateNotifier {
  List? movies;

  Movies() : super([]);

  Future<void> getMovies() async {
    String url = 'https://hoblist.com/api/movieList';
    Map<String, String> body = {
      "category": "movies",
      "language": "kannada",
      "genre": "all",
      "sort": "voting",
    };
    final response = await http.post(Uri.parse(url), body: body);
    print(response.body);
  }
}

final moviesProvider = StateNotifierProvider(((ref) => Movies()));
