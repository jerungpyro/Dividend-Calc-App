// lib/screens/about_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:unit_trust_calculator/utils/app_constants.dart';
import 'package:unit_trust_calculator/widgets/app_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // show a snackbar or dialog if the URL can't be launched
      debugPrint('Could not launch $urlString');
      // For user feedback:
      // ScaffoldMessenger.of(context).showSnackBar(
      // SnackBar(content: Text('Could not open the link: $urlString')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('About ${AppConstants.appTitle}'),
        title: const Text('About Section'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Application Icon
              Image.asset(
                AppConstants.appIconPath,
                height: 100,
                width: 100,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.business_center, size: 100, color: Colors.grey); // Placeholder if icon doesnt work
                },
              ),
              const SizedBox(height: 20),
              Text(
                AppConstants.appTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Version 1.0.0', // Current app version
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Author Information
              _buildSectionTitle(context, 'Author Information'),
              _buildInfoCard(
                children: [
                  _buildInfoRow('Name:', AppConstants.author.name),
                  _buildInfoRow('Matric No:', AppConstants.author.matricNo),
                  _buildInfoRow('Course:', AppConstants.author.course),
                ],
              ),
              const SizedBox(height: 30),

              // GitHub Repository
              _buildSectionTitle(context, 'Source Code'),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Icon(Icons.code, color: Theme.of(context).primaryColor),
                  title: const Text('GitHub Repository', style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: const Text(AppConstants.githubRepoUrl, style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                  onTap: () => _launchURL(AppConstants.githubRepoUrl),
                  trailing: const Icon(Icons.open_in_new),
                ),
              ),
              const SizedBox(height: 40),

              // Copyright Notice
              Text(
                AppConstants.copyrightNotice,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryColorDark,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildInfoCard({required List<Widget> children}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}