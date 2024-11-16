import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import '../../providers/providers.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  
  @override
  void initState() {
    super.initState();
  
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }
  
  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading == true) return const FullScreenLoader();

    final slideshowMovies = ref.watch( movieSlideshowProvider );
    final nowPlayingMovie = ref.watch( nowPlayingMoviesProvider );
    final popularMovies = ref.watch( popularMoviesProvider );
    final topRatedMovies = ref.watch( topRatedMoviesProvider );
    final upcomingMovies = ref.watch( upcomingMoviesProvider );

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index){
              return Column(
                children: [
    
                  // const CustomAppbar(),
    
                  MovieSlideshow(movies: slideshowMovies),
    
                  MovieHorizontalListview(
                    movies: nowPlayingMovie,
                    title: 'En cine',
                    subTitle: DateTime.now().day.toString(),
                    loadNextPage: ()=> ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                  ),
    
                  MovieHorizontalListview(
                    movies: upcomingMovies,
                    title: 'Mejor calificadas',
                    subTitle: 'desde siempre',
                    loadNextPage: ()=> ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                  ),
    
                  MovieHorizontalListview(
                    movies: popularMovies,
                    title: 'populares',
                    // subTitle: 'desde siempre',
                    loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
                  ),
          
                  const SizedBox(height: 10,),
                  MovieHorizontalListview(
                    movies: topRatedMovies,
                    title: 'proximamente',
                    subTitle: 'En este mes',
                    loadNextPage: ()=> ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                  ),
          
                ],
              );
            },
            childCount: 1
          ) 
        )
      ]
    );
  }
}
