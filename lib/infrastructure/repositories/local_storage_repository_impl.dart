import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import '../../domain/repositories/local_storage_repository.dart';


class LocalStorageRepositoryImpl implements LocalStorageRepository {
  
  final LocalStorageDatasource datasource;
  
  LocalStorageRepositoryImpl(this.datasource); 
    
  
  @override
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  
}