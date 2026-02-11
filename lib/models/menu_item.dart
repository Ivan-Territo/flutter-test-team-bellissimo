class MenuItem {
  final int id;
  final String piatto;
  final String categoria;
  final double prezzo;
  final List<String> ingredienti;
  final bool isVegan;
  final bool disponibile;
  final String urlImmagine;
 
  MenuItem({
    required this.id,
    required this.piatto,
    required this.categoria,
    required this.prezzo,
    required this.ingredienti,
    required this.isVegan,
    required this.disponibile,
    required this.urlImmagine,
  });
 
 
  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] as int,
      piatto: json['piatto'] as String,
      categoria: json['categoria'] as String,
      prezzo: (json['prezzo'] as num).toDouble(),
      ingredienti: List<String>.from(json['ingredienti'] as List),
      isVegan: json['is_vegan'] as bool,
      disponibile: json['disponibile'] as bool,
      urlImmagine: json['url_immagine'] as String,
    );
  }
 
 
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'piatto': piatto,
      'categoria': categoria,
      'prezzo': prezzo,
      'ingredienti': ingredienti,
      'is_vegan': isVegan,
      'disponibile': disponibile,
      'url_immagine': urlImmagine,
    };
  }
}