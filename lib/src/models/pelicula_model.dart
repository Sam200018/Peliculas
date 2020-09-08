// Generated by https://quicktype.io
class Peliculas {
  List<Pelicula> coleccion = new List();

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var elemento in jsonList) {
      final pelicula = new Pelicula.fromJsonMap(elemento);
      coleccion.add(pelicula);
    }
  }
}

class Pelicula {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.voteCount,
    this.popularity,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    popularity = json['popularity'] / 1;
    video = json['video'];
    posterPath = json['poster_path'];
    id = json['id'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['orginal_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    voteAverage = json['vote_average'] / 1;
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  getPosterImg() {
    //Creamos este método para poder retornar la imagen de cada elemento
    if (posterPath == null) {
      return 'https://admin.promosupplyer.mx/images/imagen-no-disponible.jpg'; //colocamos una por si no hay null en la consulta
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath'; // y si no es null regresamos el path del poster para poder ver esa imagen en las card
    }
  }
}
