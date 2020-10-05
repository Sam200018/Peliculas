import 'package:flutter/material.dart';

class DataSeach extends SearchDelegate {
  //Esta clase va ser el encargado de disparar la acciión en TMovieDB para traernos las peliculas con forme vamos escribiendo algo ahí
  String seleccion = ' ';

  final peliculas = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam!',
    'Ironman',
    'Capitan America',
  ];

  final peliculasRecientes = [
    'Spiderman',
    'Capitan America',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    //Las acciones de nuestro appBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          //No hace falta un setState para borrar y todo lo que haagamos en la busqueda se irá a query.
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono a la izquierda del appBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Es el builder que crea los resultados que vamos a mostrar
    return Center(
        child: Container(
      height: 100.0,
      width: 100.0,
      color: Colors.greenAccent,
      child: Text(seleccion),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Son las sugerencias que aparencen cuando la persona escribe

    final listaSugerida = (query.isEmpty)
        ? peliculasRecientes
        : peliculas
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[index]),
          onTap: () {
            seleccion = listaSugerida[index];
            showResults(
                context); // con este método que es propio de SearchDelegate podemos hacer que nos ponga el resultado en pantalla con ayuda el método BuildSugestions
          },
        );
      },
    );
  }
}
