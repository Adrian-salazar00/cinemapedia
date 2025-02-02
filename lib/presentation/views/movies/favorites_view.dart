import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/providers.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {

  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if ( isLoading || isLastPage ) return ;
    isLoading = true;

    final movies = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLastPage = false;

    if ( movies.isEmpty ) {
      isLastPage = true;
    }


  }


  @override
  Widget build(BuildContext context) {

    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if ( favoriteMovies.isEmpty ){
      final colors = Theme.of(context).colorScheme;

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border_sharp, size: 100, color: colors.primary),
            Text('Oohhh noo', style: TextStyle(fontSize: 30, color: colors.primary)),
            Text('No tienes peliculas favoritas', style: TextStyle(fontSize: 20, color: colors.primary)),

            const SizedBox(height: 20,),
            FilledButton.tonal(
              onPressed: () => context.go('/home/0'), 
              child: Text('Ir a peliculas', style: TextStyle(color: colors.primary),)
            )
          ],
        ),
      );
    }


    return Scaffold(
      body: MovieMasonry(
        loadNextPage: loadNextPage, 
        movies: favoriteMovies,
      )
    );
  }
}