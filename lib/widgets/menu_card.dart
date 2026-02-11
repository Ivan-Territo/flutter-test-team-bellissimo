import 'package:flutter/material.dart';
import '../models/menu_item.dart';
 
class MenuCard extends StatelessWidget {
  final MenuItem menuItem;
 
  const MenuCard({Key? key, required this.menuItem}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Immagine con badge vegan
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  menuItem.urlImmagine,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.restaurant_menu,
                        size: 64,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              
              // Badge Vegan
              if (menuItem.isVegan)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.eco, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'VEGAN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              
              // Badge disponibilità
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: menuItem.disponibile 
                        ? Colors.green.withOpacity(0.9)
                        : Colors.red.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    menuItem.disponibile ? 'Disponibile' : 'Esaurito',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome piatto e categoria
                Text(
                  menuItem.piatto,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 6),
                
                // Categoria
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(menuItem.categoria),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    menuItem.categoria,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Ingredienti
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.restaurant,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        menuItem.ingredienti.join(', '),
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Prezzo e pulsante ordina
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '€${menuItem.prezzo.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: menuItem.disponibile ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Ordinato: ${menuItem.piatto}'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      } : null,
                      icon: const Icon(Icons.add_shopping_cart, size: 18),
                      label: const Text('Ordina'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
 
  // Helper per assegnare colori alle categorie
  Color _getCategoryColor(String categoria) {
    switch (categoria.toLowerCase()) {
      case 'antipasti':
        return Colors.purple;
      case 'primi':
        return Colors.blue;
      case 'secondi':
        return Colors.red;
      case 'contorni':
        return Colors.green;
      case 'dolci':
        return Colors.pink;
      case 'bevande':
        return Colors.cyan;
      default:
        return Colors.grey;
    }
  }
}
 