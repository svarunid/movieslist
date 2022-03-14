import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movieslist/auth/provider/auth.dart';
import 'package:movieslist/movies/view/info_screen.dart';

import '../model/movie.dart';
import '../provider/movies_provider.dart';

class MoviesScreen extends HookConsumerWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Movie> movies = ref.watch(moviesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies List'),
      ),
      body: movies.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: (ctx, index) {
                  return MovieListItem(
                    director: movies[index].director!,
                    genre: movies[index].genre!,
                    movieName: movies[index].title!,
                    pageViews: movies[index].pageViews!,
                    releaseDate: movies[index].releasedDate!,
                    stars: movies[index].stars!,
                    url: movies[index].imgUrl!,
                    votes: movies[index].totalVoted!,
                  );
                },
                itemCount: movies.length,
              ),
            ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Movies List',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            ListTile(
              title: const Text('Company Info'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => InfoScreen())));
              },
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
  final String releaseDate;
  final String director;
  final String genre;
  final String movieName;
  final String votes;
  final String url;
  final String stars;
  final String pageViews;

  const MovieListItem({
    Key? key,
    this.director = '',
    this.genre = '',
    this.stars = '',
    this.releaseDate = '',
    this.movieName = '',
    this.votes = '',
    this.url = '',
    this.pageViews = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Column(
                  children: const [
                    Icon(Icons.arrow_drop_up),
                    Text('1'),
                    Icon(Icons.arrow_drop_down),
                    Text('Votes')
                  ],
                ),
                const SizedBox(
                  width: 8,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    url,
                    height: 120,
                    loadingBuilder: (ctx, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          text: 'Genre: ',
                          children: [
                            TextSpan(
                              text: genre,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          text: 'Director: ',
                          children: [
                            TextSpan(
                              text: director,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          text: 'Starring: ',
                          children: [
                            TextSpan(
                              text: stars,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text('Mins | Kannada | $releaseDate'),
                      Text(
                        '$pageViews | Voted by $votes people',
                        style: TextStyle(color: Colors.cyan),
                      ),
                    ],
                  ),
                )
              ],
            ),
            ElevatedButton(
              child: const Text("Watch Trailer"),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
