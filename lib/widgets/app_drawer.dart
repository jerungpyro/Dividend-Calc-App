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
    final ColorScheme colorScheme = theme.colorScheme;

    // Active color for the switch (when ON).
    // colorScheme.secondary is seafoamGreenAccent in light theme, seafoamGreenPrimary in dark.
    final Color activeSwitchColor = colorScheme.secondary;

    // Colors for the INACTIVE state of the switch (when OFF - Light Mode selected)
    final Color inactiveSwitchTrackColorLight = Colors.grey[350]!;
    final Color inactiveSwitchThumbColorLight = Colors.grey[500]!;


    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.primaryColor, // This will be seafoamGreenPrimary (0xFF8DDCDC) in light theme
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppConstants.appTitle,
                  style: TextStyle(
                    color: colorScheme.onPrimary, // Should be darkTextOnSeafoam
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
            activeColor: activeSwitchColor,

            inactiveTrackColor: isDarkMode
                ? null
                : inactiveSwitchTrackColorLight,
            inactiveThumbColor: isDarkMode
                ? null
                : inactiveSwitchThumbColorLight,

            secondary: Icon(
              isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: isDarkMode
                  ? activeSwitchColor // Moon icon color in Dark Mode (e.g., seafoamGreenPrimary for dark theme accent)
                  : theme.primaryColor, // Sun icon uses the main primary color (0xFF8DDCDC)
            ),
          ),
        ],
      ),
    );
  }
}