import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '4a428a2deefcff39097ea4a9d69f62c8';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargando =
      false; //Colocamos un tipo de bandera para poder saber cuando se estan cargando y no cargar todo siempre

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<
      List<
          Pelicula>>.broadcast(); //el .broadcast() es para que más de 1 widget puedan oir la información de este stream

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink
      .add; //forma de enviar data en este stream, que van a enviar una lista de pelicula

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController
      .stream; //forma de oir la data de este stream, que va recibir una lista de pelicula

  void disposeStreams() {
    //Este método es muy importante para que cuando no fluya información ene el stream se cierre o simplemente no se habrá el canal
    _popularesStreamController?.close();
  }

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
    if (_cargando) return [];

    _cargando =
        true; //Aquí cambaimos el estado la bandera para poder cargar los datos
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString(),
    });
    final resp = await _procesarRespuesta(url);
    _populares.addAll(
        resp); //esto de aquí puedo añadir toda la respuesta que haga por el pedido de la data

    popularesSink(_populares);
    _cargando =
        false; //Esto de acá es para regresar la bandera a su esatado original
    return resp;
  }
}
