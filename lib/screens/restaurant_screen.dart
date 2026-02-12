import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';
import '../widgets/menu_card.dart';
 
class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);
 
  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}
 
class _RestaurantScreenState extends State<RestaurantScreen> {
  String? _selectedCategory;
  bool _showOnlyVegan = false;
 
  @override
  void initState() {
    super.initState();
    // Carica il menu quando la pagina viene aperta
    Future.microtask(
      () => context.read<MenuProvider>().fetchMenu(),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ristorante - Il Nostro Menu'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          // Filtro Vegan
          IconButton(
            icon: Icon(
              _showOnlyVegan ? Icons.eco : Icons.eco_outlined,
            ),
            onPressed: () {
              setState(() {
                _showOnlyVegan = !_showOnlyVegan;
              });
            },
            tooltip: 'Solo Vegan',
          ),
        ],
      ),
      body: Consumer<MenuProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
 
          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(provider.errorMessage!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.fetchMenu(),
                    child: const Text('Riprova'),
                  ),
                ],
              ),
            );
          }
 
          if (provider.menuItems.isEmpty) {
            return const Center(
              child: Text('Nessun piatto disponibile'),
            );
          }
 
          // Filtra i piatti in base alla categoria e vegan
          var filteredItems = provider.menuItems;
          
          if (_selectedCategory != null) {
            filteredItems = provider.getItemsByCategory(_selectedCategory!);
          }
          
          if (_showOnlyVegan) {
            filteredItems = filteredItems.where((item) => item.isVegan).toList();
          }
 
          return Column(
            children: [
              // Filtro categorie
              if (provider.categories.isNotEmpty)
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildCategoryChip('Tutti', null),
                      const SizedBox(width: 8),
                      ...provider.categories.map(
                        (category) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _buildCategoryChip(category, category),
                        ),
                      ),
                    ],
                  ),
                ),
              
              // Lista piatti
              Expanded(
                child: filteredItems.isEmpty
                    ? const Center(
                        child: Text('Nessun piatto corrisponde ai filtri'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: MenuCard(menuItem: filteredItems[index]),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
 
  Widget _buildCategoryChip(String label, String? category) {
    final isSelected = _selectedCategory == category;
    
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedCategory = selected ? category : null;
        });
      },
      backgroundColor: Colors.grey[200],
      selectedColor: Colors.orange,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
 