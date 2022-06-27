class Nota {
  String titulo;
  String contenido;
  Nota(this.titulo, this.contenido);
  Map<String, dynamic> toJson() {
    return {'titulo': titulo, 'contenido': contenido};
  }
}

List<String> notas = [];
