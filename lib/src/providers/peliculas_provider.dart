import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '4a428a2deefcff39097ea4a9d69f62c8';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    // print(resp.body); toda la data que recibimos de la petición

    final decodeData = json.decode(resp.body);
    // print(decodeData['results']);//nuestra colección
    final peliculas = new Peliculas.fromJsonList(
        decodeData['results']); //la coleccion es analizada por nuestra clase

    return peliculas
        .coleccion; //regresamos la coleccion Peliculas de elementos Pelicula
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
    });
    return await _procesarRespuesta(url);
  }
}
