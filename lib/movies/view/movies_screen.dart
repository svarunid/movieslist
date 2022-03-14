import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movieslist/auth/provider/auth.dart';
import 'package:movieslist/movies/provider/movies_provider.dart';

class MoviesScreen extends HookConsumerWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(moviesProvider.notifier).getMovies();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies List'),
      ),
      body: Container(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: const Text(
                'Movies List',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            ListTile(
              title: const Text('Company Info'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                ref.read(authProvider.notifier).logOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MovieListItem extends StatelessWidget {
  final releaseDate;

  final String director;

  final String genre;

  final String movieName;

  final int votes;

  final String url;

  const MovieListItem(
      {Key? key,
      this.director = '',
      this.genre = '',
      this.releaseDate,
      this.movieName = '',
      this.votes = 0,
      this.url = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var stars;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Voting(votes: votes),
            const SizedBox(
              width: 15,
            ),
            Image.network(
              url,
              width: MediaQuery.of(context).size.width * 0.15,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  movieName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Text.rich(
                  TextSpan(
                    text: 'Genre: ',
                    children: [
                      TextSpan(text: genre),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text.rich(
                  TextSpan(
                    text: 'Director: ',
                    children: [
                      TextSpan(text: director),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text.rich(
                  TextSpan(
                    text: 'Staring: ',
                    children: [
                      TextSpan(text: stars),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text('Mins | Kannada | $releaseDate'),
              ],
            )
          ],
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Watch Trailer'),
        )
      ],
    );
  }
}

class Voting extends StatelessWidget {
  final int votes;

  const Voting({
    Key? key,
    this.votes = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        const Icon(Icons.arrow_drop_up),
        const Spacer(),
        Text(
          '$votes',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        const Icon(Icons.arrow_drop_down),
        const SizedBox(
          height: 16,
        ),
        const Text('Votes')
      ],
    );
  }
}
