import 'package:flutter/material.dart';

import 'package:peliculas/src/providers/peliculas_provider.dart';

import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';
import 'package:peliculas/src/search/seach_delegate.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider =
      new PeliculasProvider(); //lo hacemos propiedad porque probablemente lo use en otro lado

  @override
  Widget build(BuildContext context) {
    peliculasProvider
        .getPopulares(); //me va a regresar el listado del future y ejecuta el sink.add

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Peliculas en Cines'),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSeach(),
                // query: 'Gool', esto es para poder sugerir una palabra de busqueda cuando se precione la lupa
              );
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          //Aquí el snapshot contiene la colección peliculas de elemento Pelicula
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
            height: 350.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Polulares',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: peliculasProvider
                .popularesStream, //aquí no uso el future sino mi get popularesStream para decirle que se dibuje
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return Horizontal(
                  peliculas: snapshot.data,
                  siguietePagina: peliculasProvider.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}

//Builder:
//El future solo se ejucuta una sola vez y el Stream se ejecuta cada que haya un cambio
