// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:unit_trust_calculator/utils/app_constants.dart';
import 'package:unit_trust_calculator/widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _investedAmountController = TextEditingController();
  final _annualRateController = TextEditingController();
  final _monthsController = TextEditingController();

  double? _monthlyDividend;
  double? _totalDividend;

  final NumberFormat _currencyFormatter =
      NumberFormat.currency(locale: 'en_MY', symbol: 'RM ', decimalDigits: 2);

  @override
  void dispose() {
    _investedAmountController.dispose();
    _annualRateController.dispose();
    _monthsController.dispose();
    super.dispose();
  }

  void _calculateDividend() {
    if (_formKey.currentState!.validate()) {
      final double investedAmount =
          double.tryParse(_investedAmountController.text) ?? 0.0;
      final double annualRate =
          (double.tryParse(_annualRateController.text) ?? 0.0) / 100.0; // Convert % to decimal
      final int months = int.tryParse(_monthsController.text) ?? 0;

      if (investedAmount > 0 && annualRate > 0 && months > 0) {
        setState(() {
          _monthlyDividend = (annualRate / 12) * investedAmount;
          _totalDividend = _monthlyDividend! * months;
        });
      } else {
        setState(() {
          _monthlyDividend = null;
          _totalDividend = null;
        });
        // show a snackbar for invalid calculation parameters
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please enter valid positive values for calculation.'),
            backgroundColor: Theme.of(context).colorScheme.error, // Use theme error color
          ),
        );
      }
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _investedAmountController.clear();
    _annualRateController.clear();
    _monthsController.clear();
    setState(() {
      _monthlyDividend = null;
      _totalDividend = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get theme data for easy access to themed colors and styles
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appTitle),
        // AppBar styling is now primarily handled by AppBarTheme in main.dart
        // backgroundColor: theme.primaryColor, // This is okay, or let AppBarTheme handle it
        // foregroundColor: theme.appBarTheme.foregroundColor, // This is okay, or let AppBarTheme handle it
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Enter Investment Details',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColorDark, // Adapts based on theme
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                context: context, // Pass context for theme access
                controller: _investedAmountController,
                labelText: 'Invested Fund Amount (RM)',
                icon: Icons.attach_money,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter invested amount';
                  }
                  if (double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'Please enter a valid positive amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                context: context,
                controller: _annualRateController,
                labelText: 'Annual Dividend Rate (%)',
                icon: Icons.percent,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter annual rate';
                  }
                   if (double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'Please enter a valid positive rate';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                context: context,
                controller: _monthsController,
                labelText: 'Number of Months Invested',
                icon: Icons.calendar_today,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter number of months';
                  }
                  final int? months = int.tryParse(value);
                  if (months == null || months <= 0) {
                    return 'Please enter a valid positive number of months';
                  }
                  if (months > 12) {
                    return 'Months cannot exceed 12';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.clear_all),
                      onPressed: _resetForm,
                      style: ElevatedButton.styleFrom(
                        // Use a less prominent color for Reset, or a color from the scheme
                        backgroundColor: colorScheme.surfaceVariant, // Adapts
                        foregroundColor: colorScheme.onSurfaceVariant, // Adapts
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: textTheme.labelLarge?.copyWith(fontSize: 16),
                      ),
                      label: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.calculate),
                      onPressed: _calculateDividend,
                      style: ElevatedButton.styleFrom(
                        // ElevatedButtonTheme in main.dart handles this, but can override
                        backgroundColor: theme.primaryColor, // Adapts
                        foregroundColor: textTheme.labelLarge?.color, // Adapts, e.g. colorScheme.onPrimary
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: textTheme.labelLarge?.copyWith(fontSize: 16),
                      ),
                      label: const Text('Calculate'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              if (_totalDividend != null) _buildResultsCard(context), // Pass context for theme access
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context, // Pass context for theme access
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    // InputDecorationTheme in main.dart handles most styling for borders, fill, prefixIconColor
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        // prefixIconColor is now handled by InputDecorationTheme in main.dart
        prefixIcon: Icon(icon),
        // filled and fillColor are also handled by InputDecorationTheme
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      // Use themed text style for input
      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16),
    );
  }

  Widget _buildResultsCard(BuildContext context) { // Pass context for theme access
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    // CardTheme in main.dart handles elevation, shape, margin, and its background color
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calculation Results:',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor, // Adapts
              ),
            ),
            const SizedBox(height: 12),
            if (_monthlyDividend != null)
              _buildResultRow(context, 'Monthly Dividend:', _currencyFormatter.format(_monthlyDividend!)),
            if (_totalDividend != null)
              _buildResultRow(context, 'Total Dividend (for ${_monthsController.text} months):', _currencyFormatter.format(_totalDividend!), isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(BuildContext context, String label, String value, {bool isTotal = false}) { // Pass context for theme access
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: textTheme.bodyLarge?.copyWith( // Use textTheme
              color: textTheme.bodyMedium?.color?.withOpacity(0.8), // Adapts, slightly dimmer
            ),
          ),
          Text(
            value,
            style: (isTotal ? textTheme.titleMedium : textTheme.bodyLarge)?.copyWith( // Use textTheme
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? theme.primaryColorDark : textTheme.bodyLarge?.color, // Adapts
            ),
          ),
        ],
      ),
    );
  }
}