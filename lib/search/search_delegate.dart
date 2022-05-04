
import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  String get searchFieldLabel => 'Buscar Pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  Widget _emptyContainer( BuildContext context ) {
    return Container(
      child: const Center(
        child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 100,),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer( context );
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery( query );

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List <Movie>> snapshot) {
        if (!snapshot.hasData)  return _emptyContainer( context );
        
        final searchData = snapshot.data!;

        return ListView.builder(
          itemCount: searchData.length,
          itemBuilder: (_, int index) => _MovieItem(movie: searchData[index]),
        );
      },
    );
  }

}

class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem({
    Key? key,
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${ movie.id }';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          image: NetworkImage(movie.fullPosterImg),
          placeholder: const AssetImage('assets/no-image.jpg'),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
    );
  }
}