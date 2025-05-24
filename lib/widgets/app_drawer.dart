// lib/widgets/app_drawer.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unit_trust_calculator/providers/theme_provider.dart';
import 'package:unit_trust_calculator/utils/app_constants.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final ThemeData theme = Theme.of(context);

    // Active color for the switch (when it's ON - i.e., Dark Mode selected)
    // This should be your app's primary accent, e.g., theme.primaryColor or a specific teal.
    final Color activeSwitchColor = theme.primaryColor;

    // Colors for the INACTIVE state of the switch (when it's OFF - i.e., Light Mode selected)
    // We want these to be visible on a light background.
    final Color inactiveSwitchTrackColorLight = Colors.grey[400]!; // A more visible grey for the track
    final Color inactiveSwitchThumbColorLight = Colors.grey[600]!; // A slightly darker grey for the thumb

    // For Dark Mode, the default inactive colors are usually fine, but you can specify if needed.
    // final Color inactiveSwitchTrackColorDark = Colors.grey[700]!;
    // final Color inactiveSwitchThumbColorDark = Colors.grey[500]!;


    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppConstants.appTitle,
                  style: TextStyle(
                    color: theme.appBarTheme.foregroundColor ?? Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: theme.listTileTheme.iconColor),
            title: Text('Home', style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
            onTap: () {
              Navigator.pop(context);
              if (ModalRoute.of(context)?.settings.name != AppConstants.homeRoute) {
                Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: theme.listTileTheme.iconColor),
            title: Text('About', style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
            onTap: () {
              Navigator.pop(context);
               if (ModalRoute.of(context)?.settings.name != AppConstants.aboutRoute) {
                Navigator.pushReplacementNamed(context, AppConstants.aboutRoute);
              }
            },
          ),
          const Divider(),
          SwitchListTile(
            title: Text(
              isDarkMode ? 'Dark Mode' : 'Light Mode',
              style: TextStyle(color: theme.textTheme.bodyMedium?.color),
            ),
            value: isDarkMode,
            onChanged: (bool value) {
              themeProvider.toggleTheme(value);
            },
            activeColor: activeSwitchColor, // Color when ON (Dark Mode)
            // activeTrackColor: activeSwitchColor.withOpacity(0.6), // Optional: slightly lighter track when ON

            // Explicitly set inactive colors for better visibility in Light Mode
            inactiveTrackColor: isDarkMode
                ? null // Use default dark theme inactive track or specify dark inactive track color
                : inactiveSwitchTrackColorLight,
            inactiveThumbColor: isDarkMode
                ? null // Use default dark theme inactive thumb or specify dark inactive thumb color
                : inactiveSwitchThumbColorLight,

            secondary: Icon(
              isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: isDarkMode
                  ? theme.colorScheme.secondary // Moon icon color in Dark Mode
                  : activeSwitchColor,       // Sun icon color in Light Mode (matches the active switch color)
            ),
          ),
        ],
      ),
    );
  }
}