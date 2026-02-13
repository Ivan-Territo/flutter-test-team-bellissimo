import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/restaurant_page.dart';
import 'services/menu_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MenuService())],
      child: MaterialApp(
        title: 'Flutter Exam',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const RestaurantPage(),
        routes: {'/restaurant': (context) => const RestaurantPage()},
      ),
    );
  }
}
