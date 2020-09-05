import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Peliculas en Cines'),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            _swiperTarjetas(),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: double.infinity, //ocupar todo el ancho disponible
      height: 300.0,
      child: Swiper(
        layout: SwiperLayout
            .STACK, //1. para que esta propiedad funcione tenemos que hacer ponerle por lo menos el ancho de las tarjetas
        itemWidth:
            200.0, //2. este es el ancho de las tarjetas que tenemos que ponerle por lo menos para que lo en encima funcione
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "http://via.placeholder.com/350x150",
            fit: BoxFit.fill,
          );
        },
        itemCount: 3,
        // pagination:
        //     new SwiperPagination(), //barra para saber cuantas páginas tengo en el swiper
        // control: new SwiperControl(), // me indica hacia donde tenemos que girar
      ),
    );
  }
}
