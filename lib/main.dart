// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unit_trust_calculator/providers/theme_provider.dart'; // Import ThemeProvider
import 'package:unit_trust_calculator/screens/about_screen.dart';
import 'package:unit_trust_calculator/screens/home_screen.dart';
import 'package:unit_trust_calculator/utils/app_constants.dart';

void main() {
  // Ensure widgets are initialized before using SharedPreferences or other plugins
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(), // Create an instance of ThemeProvider
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Consume the ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode, // Set themeMode from provider
      theme: ThemeData( // Light Theme
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        primaryColor: Colors.teal,
        primaryColorDark: Colors.teal[700],
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          elevation: 4.0,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Ensure title text is white for light theme appbar
          ),
          iconTheme: const IconThemeData(color: Colors.white), // For drawer icon
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.grey[100], // Light background for drawer
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.teal[200]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.teal[700]!, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.teal[700]),
          prefixIconColor: Colors.teal[700],
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.white,
        ),
        listTileTheme: ListTileThemeData(
          iconColor: Colors.teal[700], // Icon color for ListTiles in light mode
        ),
        textTheme: const TextTheme(
           titleLarge: TextStyle(color: Colors.black87),
           bodyMedium: TextStyle(color: Colors.black87),
           labelLarge: TextStyle(color: Colors.white) // For ElevatedButton text
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // For SwitchListTile active color in light mode
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal).copyWith(secondary: Colors.tealAccent[700]),
      ),
      darkTheme: ThemeData( // Dark Theme
        brightness: Brightness.dark,
        primarySwatch: Colors.teal, // You might want a different swatch for dark mode
        primaryColor: Colors.teal[600], // Slightly lighter teal for dark mode primary
        primaryColorDark: Colors.teal[800],
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[850], // Darker app bar
          foregroundColor: Colors.white,
          elevation: 4.0,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.grey[800], // Dark background for drawer
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal[400],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[700]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.teal[300]!, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.grey[400]),
          prefixIconColor: Colors.teal[300],
          fillColor: Colors.grey[800], // Darker fill for text fields
          filled: true,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.grey[850], // Darker card color
        ),
        listTileTheme: ListTileThemeData(
          iconColor: Colors.teal[300], // Icon color for ListTiles in dark mode
        ),
        textTheme: TextTheme(
           titleLarge: const TextStyle(color: Colors.white70),
           bodyMedium: const TextStyle(color: Colors.white70),
           labelLarge: const TextStyle(color: Colors.white) // For ElevatedButton text
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // For SwitchListTile active color in dark mode
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal, brightness: Brightness.dark).copyWith(secondary: Colors.tealAccent[200]),
      ),
      initialRoute: AppConstants.homeRoute,
      routes: {
        AppConstants.homeRoute: (context) => const HomeScreen(),
        AppConstants.aboutRoute: (context) => const AboutScreen(),
      },
    );
  }
}