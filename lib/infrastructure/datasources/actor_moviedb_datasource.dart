import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mappers.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ActorMovieDbDatasource extends ActorsDatasource{

    final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDBKey,
        'language': 'es-MX'
      } 
    ));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {


    final response = await dio.get('/movie/$movieId/credits');
    if( response.statusCode != 200 ) {
      const SnackBar(content: Text('Problemas de conexión'));
      return getActorsByMovie(movieId);
    }
    


    final castResponse = CreditsResponse.fromJson(response.data);
    List<Actor> actors = castResponse.cast.map((cast) => 
      ActorMapper.castToEntity(cast)
    ).toList();

    return actors;
  }
}