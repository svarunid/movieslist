import 'package:intl/intl.dart';

class Movie {
  final String? director;
  final String? stars;
  final String? releasedDate;
  final String? title;
  final String? genre;
  final String? pageViews;
  final String? totalVoted;
  final String? imgUrl;

  Movie({
    this.director,
    this.stars,
    this.releasedDate,
    this.title,
    this.genre,
    this.pageViews,
    this.totalVoted,
    this.imgUrl,
  });

  Movie.fromJson(json)
      : title = json['title'],
        releasedDate = DateFormat('d MMM')
            .format(
              DateTime.fromMillisecondsSinceEpoch(json['releasedDate'] * 1000),
            )
            .toString(),
        director = json['director'].join(','),
        stars = json['stars'].join(','),
        genre = json['genre'],
        pageViews = json['pageViews'].toString(),
        totalVoted = json['totalVoted'].toString(),
        imgUrl = json['poster'];
}
