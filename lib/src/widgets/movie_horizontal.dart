import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class Horizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguietePagina; //se agrego una propiedad que es un callback

  Horizontal({@required this.peliculas, @required this.siguietePagina});
  //la función es requerida para que esto pueda funcionar y se puedan ver una lista infinita de pelis chidas

  final _pageController = new PageController(
    //el controlador lo pasamos una sola variable
    initialPage: 1,
    viewportFraction: 0.25,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      //cada que escuche que llegamos al final del inifite scroll y eso menos 200 pixeles se va a ejeutar la función que recibe esta class
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguietePagina(); // esta es la función que recibe nuestra class
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
          pageSnapping: false,
          controller: _pageController,
          itemCount: peliculas.length,
          itemBuilder: (context, i) => _tarjeta(context, peliculas[i])),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-horizontal';
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 120.0,
              ),
            ),
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }

  // // List<Widget> _tarjetas(BuildContext context) {
  //   return peliculas.map((pelicula) {
  //     return Container(
  //       margin: EdgeInsets.only(right: 15.0),
  //       child: Column(
  //         children: [
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(20.0),
  //             child: FadeInImage(
  //               placeholder: AssetImage('assets/img/no-image.jpg'),
  //               image: NetworkImage(pelicula.getPosterImg()),
  //               fit: BoxFit.cover,
  //               height: 120.0,
  //             ),
  //           ),
  //           Text(
  //             pelicula.title,
  //             overflow: TextOverflow.ellipsis,
  //             style: Theme.of(context).textTheme.caption,
  //           ),
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }
}
