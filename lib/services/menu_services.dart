import 'package:flutter/foundation.dart';
import '../models/menu_item.dart';
import '../services/api_service.dart';
 
class MenuService with ChangeNotifier {
  final ApiService _apiService = ApiService();
 
  List<MenuItem> _menuItems = [];
  bool _isLoading = false;
  String? _errorMessage;
 
  List<MenuItem> get menuItems => _menuItems;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
 
 
  Future<void> fetchMenu() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
 
    try {
      final data = await _apiService.getMenu();
      _menuItems = data.map((json) => MenuItem.fromJson(json)).toList();
    } catch (e) {
      _errorMessage = 'Errore nel caricamento del menu: $e';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
 
 
  List<MenuItem> get availableItems =>
      _menuItems.where((item) => item.disponibile).toList();
 
 
  List<MenuItem> get veganItems =>
      _menuItems.where((item) => item.isVegan).toList();
 
 
  List<MenuItem> getItemsByCategory(String categoria) {
    return _menuItems.where((item) => item.categoria == categoria).toList();
  }
 
 
  List<String> get categories {
    return _menuItems.map((item) => item.categoria).toSet().toList()..sort();
  }
}