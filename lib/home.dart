import 'package:flutter/material.dart';
import 'package:latihan_5/HttpHelper.dart';
import 'package:latihan_5/detail.dart';
import 'package:latihan_5/movies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HttpHelper? helper;
  List? movies;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage ='https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  Future<void> initialize() async {
    helper = HttpHelper();
    movies = await helper?.getMovies();
    setState(() {
      movies = movies;
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;

    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing'),
      ),
      body: ListView.builder(
        itemCount: (movies?.length == null) ? 0 : movies!.length,
        itemBuilder: (BuildContext context, int position) {
          if (movies![position].posterPath != null) {
            image = NetworkImage(iconBase + movies![position].posterPath);
          } else {
            image = NetworkImage(defaultImage);
          }
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (_) => DetailScreen(movies![position]));
                Navigator.push(context, route);
              },
              leading: CircleAvatar(
                backgroundImage: image,
              ),
              title: Text(movies![position].title),
              subtitle: Text('Released: ' +
                  movies![position].releaseDate +
                  ' - Vote: ' +
                  movies![position].voteAverage.toString()),
            ),
          );
        },
      ),
    );
  }
}


