// lib/screens/about_screen.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // <-- IMPORT THIS
import 'package:url_launcher/url_launcher.dart';
import 'package:unit_trust_calculator/utils/app_constants.dart';
import 'package:unit_trust_calculator/widgets/app_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchURL(BuildContext context, String urlString) async { // Added BuildContext for ScaffoldMessenger
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $urlString');
      if (context.mounted) { // Check if the widget is still in the tree
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open the link: $urlString')),
        );
      }
    }
  }

  // Helper widget for social icons
  Widget _buildSocialIcon({
    required BuildContext context, // Pass context
    required IconData icon,
    required String url,
    required Color iconColor,
    required Color backgroundColor,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () => _launchURL(context, url), // Pass context to _launchURL
        borderRadius: BorderRadius.circular(12), // For ink splash effect
        child: Container(
          width: 50, // Adjust size as needed
          height: 50, // Adjust size as needed
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12), // Rounded square
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: FaIcon(
              icon,
              color: iconColor,
              size: 24, // Adjust icon size as needed
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About ${AppConstants.appTitle}'),
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
                  return const Icon(Icons.business_center, size: 100, color: Colors.grey);
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
                'Version 1.0.0',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              _buildSectionTitle(context, 'Author Information'),
              _buildInfoCard(
                children: [
                  _buildInfoRow('Name:', AppConstants.author.name),
                  _buildInfoRow('Matric No:', AppConstants.author.matricNo),
                  _buildInfoRow('Course:', AppConstants.author.course),
                ],
              ),
              const SizedBox(height: 30),

              // --- START: SOCIAL MEDIA ICONS ---
              _buildSectionTitle(context, 'Connect with me'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildSocialIcon(
                      context: context,
                      icon: FontAwesomeIcons.instagram,
                      url: AppConstants.instagramUrl,
                      iconColor: Colors.white,
                      backgroundColor: const Color(0xFFC13584), // Instagram pink/purple
                      tooltip: 'Instagram',
                    ),
                    const SizedBox(width: 20),
                    _buildSocialIcon(
                      context: context,
                      icon: FontAwesomeIcons.linkedinIn,
                      url: AppConstants.linkedinUrl,
                      iconColor: Colors.white,
                      backgroundColor: const Color(0xFF0077B5), // LinkedIn blue
                      tooltip: 'LinkedIn',
                    ),
                    const SizedBox(width: 20),
                    _buildSocialIcon(
                      context: context,
                      icon: FontAwesomeIcons.github,
                      url: AppConstants.githubProfileUrl, // Use profile URL or repo URL
                      iconColor: Colors.white,
                      backgroundColor: const Color(0xFF333333), // GitHub dark grey
                      tooltip: 'GitHub',
                    ),
                  ],
                ),
              ),
              // --- END: SOCIAL MEDIA ICONS ---
              const SizedBox(height: 20), // Adjust spacing if needed

              _buildSectionTitle(context, 'Source Code'),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Icon(Icons.code, color: Theme.of(context).primaryColor),
                  title: const Text('GitHub Repository', style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text(
                    AppConstants.githubRepoUrl,
                    style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                    overflow: TextOverflow.ellipsis, // Handle long URLs
                  ),
                  onTap: () => _launchURL(context, AppConstants.githubRepoUrl), // Pass context
                  trailing: const Icon(Icons.open_in_new),
                ),
              ),
              const SizedBox(height: 40),

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