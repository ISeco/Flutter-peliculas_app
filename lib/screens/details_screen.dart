import 'package:flutter/material.dart';

import 'package:peliculas_app/widgets/widgets.dart';
import 'package:peliculas_app/models/models.dart';

class DetailsScreen extends StatelessWidget {

  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar( currentMovie: movie ),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTile( currentMovie: movie),
              _Overview(currentMovie: movie),
              CastingCard( movieId: movie.id ),
            ])
          ),
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie currentMovie;

  const _CustomAppBar({
    Key? key,
    required this.currentMovie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          color: Colors.black26,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: ConstrainedBox(
            constraints: const BoxConstraints( maxWidth: 300 ),
            child: Text(
              currentMovie.title,
              style: const TextStyle( fontSize: 16 ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        background: FadeInImage(
          placeholder: const  AssetImage('assets/loading.gif'),
          image: NetworkImage(currentMovie.fullBackDropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTile extends StatelessWidget {

  final Movie currentMovie;

  const _PosterAndTile({
    Key? key,
    required this.currentMovie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme =  Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric( horizontal: 10 ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Hero(
              tag: currentMovie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage(
                  image: NetworkImage(currentMovie.fullPosterImg),
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  height: 150,
                ),
              ),
            ),
          ),

          ConstrainedBox(
            constraints: BoxConstraints( maxWidth: size.width - 190 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentMovie.title,
                  style: textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  currentMovie.originalTitle,
                  style: textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    const Icon(Icons.star, size: 20, color: Colors.yellow),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text('${currentMovie.voteAverage}', style: textTheme.caption),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  final Movie currentMovie;

  const _Overview({
    Key? key,
    required this.currentMovie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        currentMovie.overview ?? '',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}