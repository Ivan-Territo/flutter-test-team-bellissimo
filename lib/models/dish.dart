// class Dish {
//   // TODO: Aggiungi qui le variabili della classe
//   // Suggerimento: guarda la struttura JSON nel README.md
//   var id;
//   var piatto;
//   var categoria;
//   var prezzo;
//   var ingredienti;
//   var isVegan;
//   var disponibile;
//   var urlImmagine;

//   Dish({id, piatto, categoria, prezzo, ingredienti, isVegan, disponibile, urlImmagine}) {
//     // TODO: Inizializza le variabili della classe usando i parametri del costruttore
//     this.id = id;
//     this.piatto = piatto;
//     this.prezzo = prezzo;
//     this.ingredienti = ingredienti;
//     this.isVegan = isVegan;
//     this.disponibile = disponibile;
//     this.urlImmagine = urlImmagine;
//   }

//   factory Dish.fromJson(Map<String, dynamic> json) {
//     return Dish(
//       id: json['id'],
//       piatto: json['piatto'],
//       categoria: json['categoria'],
//       prezzo: json['prezzo'].toDouble(),
//       ingredienti: List<String>.from(json['ingredienti']),
//       isVegan: json['is_vegan'],
//       disponibile: json['disponibile'],
//       urlImmagine: json['url_immagine'],
//     );
//   }
// }
