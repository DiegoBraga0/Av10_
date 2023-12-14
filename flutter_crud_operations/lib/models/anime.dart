class Anime {
  final String name;
  final String tipo;
  final String estado;
  final int episodios;

  const Anime({
    required this.name,
    required this.tipo,
    required this.estado,
    required this.episodios,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'tipo': tipo,
      'estado': estado,
      'episodios': episodios, 
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Anime{name: $name, tipo: $tipo, estado: $estado, episodios: $episodios, }';
  }
} // main