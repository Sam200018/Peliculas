import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula>
      peliculas; //se cambio porque estaba en dynamic y lo queremos en pelicula
  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context)
        .size; //para hacer la mediaQuery usamos el context es por ello que debe de estar dentro de nuestro método build

    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          top: 2.0,
          bottom: 0.0,
        ),
        child: Swiper(
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.55,
          layout: SwiperLayout
              .STACK, //1. para que esta propiedad funcione tenemos que hacer ponerle por lo menos el ancho de las tarjetas
          itemBuilder: (BuildContext context, int index) {
            peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';
            return Hero(
              tag: peliculas[index].uniqueId,
              child: ClipRRect(
                  //espara crear un clip de tarjetas de determinada imagen o cosa
                  borderRadius: BorderRadius.circular(20.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'detalle',
                        arguments: peliculas[index]),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      image: NetworkImage(peliculas[index].getPosterImg()),
                      fit: BoxFit.cover,
                    ),
                  )),
            );
          },
          itemCount: peliculas.length,
          // pagination:
          //     new SwiperPagination(), //barra para saber cuantas páginas tengo en el swiper
          // control: new SwiperControl(), // me indica hacia donde tenemos que girar
        ),
      ),
    );
  }
}
