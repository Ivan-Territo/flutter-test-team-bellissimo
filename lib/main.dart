import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'screens/hotel_screen.dart';
import 'screens/restaurant_screen.dart';
import 'providers/room_provider.dart';
import 'providers/menu_provider.dart';
 
void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoomProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        // Aggiungerai BoardProvider dopo
      ],
      child: MaterialApp(
        title: 'Flutter Exam',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
        routes: {
          '/hotel': (context) => const HotelScreen(),
          '/restaurant': (context) => const RestaurantScreen(),
          // Aggiungerai /surf dopo
        },
      ),
    );
  }
}
 
