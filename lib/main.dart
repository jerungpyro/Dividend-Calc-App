// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unit_trust_calculator/providers/theme_provider.dart';
import 'package:unit_trust_calculator/screens/about_screen.dart';
import 'package:unit_trust_calculator/screens/home_screen.dart';
import 'package:unit_trust_calculator/utils/app_constants.dart';

// Helper function to create MaterialColor
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

// Define Seafoam Green colors based on #8DDCDC
const Color seafoamGreenPrimary = Color(0xFF8DDCDC);
const Color seafoamGreenDark = Color(0xFF6ABABA);
const Color seafoamGreenLight = Color(0xFFB0EAEA);
const Color seafoamGreenAccent = Color(0xFFA0E5E5);

// Define a dark text color for contrast on light seafoam backgrounds
const Color darkTextOnSeafoam = Colors.black87;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(), // MyApp is const
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // MyApp constructor is const

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData( // ThemeData constructor is NOT const
        brightness: Brightness.light,
        primarySwatch: createMaterialColor(seafoamGreenPrimary),
        primaryColor: seafoamGreenPrimary, // const value
        primaryColorDark: seafoamGreenDark, // const value
        primaryColorLight: seafoamGreenLight, // const value

        scaffoldBackgroundColor: Colors.grey[50], // NOT const

        appBarTheme: AppBarTheme( // NOT const
          backgroundColor: seafoamGreenPrimary,
          foregroundColor: darkTextOnSeafoam,
          elevation: 2.0,
          titleTextStyle: TextStyle( // This TextStyle is fine as AppBarTheme is not const
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: darkTextOnSeafoam, // darkTextOnSeafoam is const
          ),
          iconTheme: IconThemeData(color: darkTextOnSeafoam), // IconThemeData constructor is not const
        ),
        drawerTheme: DrawerThemeData( // NOT const
          backgroundColor: Colors.grey[100],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData( // NOT const
          style: ElevatedButton.styleFrom( // styleFrom is a static method, not const constructor
            backgroundColor: seafoamGreenPrimary,
            foregroundColor: darkTextOnSeafoam,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // const EdgeInsets
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500), // This TextStyle can be const
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme( // NOT const
          filled: true,
          fillColor: Colors.grey[200], // NOT const
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey[350]!), // NOT const
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: seafoamGreenDark, width: 2),
          ),
          labelStyle: TextStyle(color: seafoamGreenDark.withOpacity(0.9)),
          prefixIconColor: seafoamGreenDark.withOpacity(0.8),
        ),
        cardTheme: CardTheme( // NOT const
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4), // const EdgeInsets
          color: Colors.white, // Colors.white is const
        ),
        listTileTheme: ListTileThemeData( // NOT const
          iconColor: seafoamGreenDark,
          selectedColor: seafoamGreenPrimary,
        ),
        textTheme: TextTheme( // TextTheme constructor is NOT const
           titleLarge: TextStyle(color: seafoamGreenDark, fontWeight: FontWeight.w600),
           titleMedium: TextStyle(color: Colors.grey[800]), // Colors.grey[800] is NOT const
           bodyLarge: TextStyle(color: Colors.grey[700]), // Colors.grey[700] is NOT const
           bodyMedium: TextStyle(color: Colors.grey[600]), // Colors.grey[600] is NOT const
           labelLarge: TextStyle(color: darkTextOnSeafoam, fontWeight: FontWeight.w500)
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity, // const value
        colorScheme: ColorScheme.fromSwatch( // fromSwatch is a factory, not const
            primarySwatch: createMaterialColor(seafoamGreenPrimary),
            brightness: Brightness.light,
            // accentColor: seafoamGreenAccent, // Deprecated. Set via copyWith -> secondary
        ).copyWith(
            primary: seafoamGreenPrimary,
            secondary: seafoamGreenAccent,
            surface: Colors.white, // Colors.white is const
            onPrimary: darkTextOnSeafoam,
            onSecondary: darkTextOnSeafoam,
            onSurface: Colors.black87, // Colors.black87 is const
            error: Colors.red[700], // NOT const
        ),
      ),
      darkTheme: ThemeData( // ThemeData constructor is NOT const
        brightness: Brightness.dark,
        primarySwatch: createMaterialColor(seafoamGreenAccent),
        primaryColor: seafoamGreenAccent,
        primaryColorDark: seafoamGreenPrimary,
        primaryColorLight: const Color(0xFFC4F1F1), // Can be const
        scaffoldBackgroundColor: const Color(0xFF121212), // Can be const

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[850],
          foregroundColor: seafoamGreenLight,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: seafoamGreenLight,
          ),
          iconTheme: IconThemeData(color: seafoamGreenLight),
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.grey[850],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: seafoamGreenAccent,
            foregroundColor: darkTextOnSeafoam,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[800],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey[700]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: seafoamGreenAccent, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.grey[400]),
          prefixIconColor: seafoamGreenAccent.withOpacity(0.8),
        ),
        cardTheme: CardTheme(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          color: Colors.grey[850],
        ),
        listTileTheme: ListTileThemeData(
          iconColor: seafoamGreenAccent,
          selectedColor: seafoamGreenPrimary,
        ),
        textTheme: TextTheme(
           titleLarge: TextStyle(color: seafoamGreenLight, fontWeight: FontWeight.w600),
           titleMedium: TextStyle(color: Colors.white.withOpacity(0.87)),
           bodyLarge: TextStyle(color: Colors.white.withOpacity(0.75)),
           bodyMedium: TextStyle(color: Colors.white.withOpacity(0.60)),
           labelLarge: TextStyle(color: darkTextOnSeafoam, fontWeight: FontWeight.w500)
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: createMaterialColor(seafoamGreenAccent),
            brightness: Brightness.dark,
            // accentColor: seafoamGreenPrimary, // Deprecated
        ).copyWith(
            primary: seafoamGreenAccent,
            secondary: seafoamGreenPrimary,
            surface: Colors.grey[850]!,
            onPrimary: darkTextOnSeafoam,
            onSecondary: darkTextOnSeafoam,
            onSurface: Colors.white.withOpacity(0.87),
            error: Colors.redAccent[100], // NOT const
        ),
      ),
      initialRoute: AppConstants.homeRoute,
      routes: {
        AppConstants.homeRoute: (context) => const HomeScreen(),
        AppConstants.aboutRoute: (context) => const AboutScreen(),
      },
    );
  }
}