// lib/widgets/app_drawer.dart
import 'package:flutter/material.dart';
import 'package:unit_trust_calculator/utils/app_constants.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Optional: App Icon in Drawer Header (Currently Doesn't Work)
                // Image.asset(AppConstants.appIconPath, height: 60, width: 60),
                // const SizedBox(height: 10),
                Text(
                  AppConstants.appTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              if (ModalRoute.of(context)?.settings.name != AppConstants.homeRoute) {
                Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
               if (ModalRoute.of(context)?.settings.name != AppConstants.aboutRoute) {
                Navigator.pushReplacementNamed(context, AppConstants.aboutRoute);
              }
            },
          ),
        ],
      ),
    );
  }
}