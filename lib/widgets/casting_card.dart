import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCard extends StatelessWidget {

  final int movieId;

  const CastingCard({
    Key? key,
    required this.movieId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: ( _ , AsyncSnapshot<List<CastMovie>> snapshot ) {
        if (snapshot.data == null || !snapshot.hasData) {
          return Container(
            width: double.infinity,
            height: 185,
            child: const Center(
              child: CircularProgressIndicator(),
            ),  
          );
        }
        final castActor = snapshot.data!;
        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 200,
          child: ListView.builder(
            itemCount: castActor.length >= 10 ? 10 : castActor.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _CastCard( actor: castActor[index] ),
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {

  final CastMovie actor;

  const _CastCard({
    Key? key,
    required this.actor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme =  Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.only(top: 5),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: FadeInImage(
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(actor.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Text(
                  actor.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge,
                ),
                Text(
                  actor.character ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}