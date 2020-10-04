import 'package:flutter/material.dart';

class DataSeach extends SearchDelegate {
  //Esta clase va ser el encargado de disparar la acciión en TMovieDB para traernos las peliculas con forme vamos escribiendo algo ahí
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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Son las sugerencias que aparencen cuando la persona escribe
    return Container();
  }
}
