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
  bool _showDetails = false; // To control visibility of the detailed breakdown

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
          (double.tryParse(_annualRateController.text) ?? 0.0) / 100.0;
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please enter valid positive values for calculation.'),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
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
      _showDetails = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    final TextStyle titleLargeStyle = textTheme.titleLarge ?? const TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
    final TextStyle labelLargeStyle = textTheme.labelLarge ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appTitle),
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
                style: titleLargeStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColorDark,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                context: context,
                controller: _investedAmountController,
                labelText: 'Invested Fund Amount (RM)',
                icon: Icons.attach_money,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) { return 'Please enter invested amount'; }
                  if (double.tryParse(value) == null || double.parse(value) <= 0) { return 'Please enter a valid positive amount';}
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
                  if (value == null || value.isEmpty) { return 'Please enter annual rate'; }
                  if (double.tryParse(value) == null || double.parse(value) <= 0) { return 'Please enter a valid positive rate'; }
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
                  if (value == null || value.isEmpty) { return 'Please enter number of months'; }
                  final int? months = int.tryParse(value);
                  if (months == null || months <= 0) { return 'Please enter a valid positive number of months'; }
                  if (months > 12) { return 'Months cannot exceed 12'; }
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
                        backgroundColor: colorScheme.surfaceVariant,
                        foregroundColor: colorScheme.onSurfaceVariant,
                        textStyle: labelLargeStyle,
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
                        backgroundColor: theme.primaryColor,
                        foregroundColor: colorScheme.onPrimary,
                        textStyle: labelLargeStyle,
                      ),
                      label: const Text('Calculate'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              if (_totalDividend != null) ...[
                _buildResultsSummaryCard(context),
                const SizedBox(height: 16),
                Center(
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: theme.primaryColorDark.withOpacity(0.4))
                      )
                    ),
                    icon: Icon(
                      _showDetails ? Icons.expand_less : Icons.expand_more,
                      color: theme.primaryColorDark,
                      size: 20,
                    ),
                    label: Text(
                      _showDetails ? 'Hide Details' : 'Show Details',
                      style: labelLargeStyle.copyWith(
                        color: theme.primaryColorDark,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _showDetails = !_showDetails;
                      });
                    },
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return SizeTransition(
                      sizeFactor: animation,
                      axisAlignment: -1.0,
                      child: child,
                    );
                  },
                  child: _showDetails
                      ? Column(
                          key: const ValueKey<bool>(true),
                          children: [
                            const SizedBox(height: 16),
                            _buildDetailedBreakdownSection(context),
                          ],
                        )
                      : const SizedBox.shrink(key: ValueKey<bool>(false)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleMediumStyle = theme.textTheme.titleMedium ?? const TextStyle(fontSize: 16);

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      style: titleMediumStyle,
    );
  }

  Widget _buildResultsSummaryCard(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle titleLargeStyle = textTheme.titleLarge ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calculation Results:',
              style: titleLargeStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
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

  Widget _buildResultRow(BuildContext context, String label, String value, {bool isTotal = false}) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle bodyLargeStyle = textTheme.bodyLarge ?? const TextStyle(fontSize: 16);
    final TextStyle bodyMediumStyle = textTheme.bodyMedium ?? const TextStyle(fontSize: 14);
    final TextStyle titleMediumStyle = textTheme.titleMedium ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: bodyLargeStyle.copyWith(
              color: bodyMediumStyle.color?.withOpacity(0.85),
            ),
          ),
          Text(
            value,
            style: (isTotal ? titleMediumStyle : bodyLargeStyle).copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? theme.primaryColorDark : bodyLargeStyle.color,
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for creating consistently formatted detail rows
  Widget _buildDetailRow(BuildContext context, String label, String value, {bool isFormula = false, bool isSubValue = false}) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    // Fallback text styles
    final TextStyle defaultBodyMedium = textTheme.bodyMedium ?? const TextStyle(fontSize: 14);
    final TextStyle defaultBodySmall = textTheme.bodySmall ?? const TextStyle(fontSize: 12);

    final TextStyle labelStyle = (isFormula ? defaultBodySmall : defaultBodyMedium).copyWith(
      fontStyle: isFormula ? FontStyle.italic : FontStyle.normal,
      color: isFormula ? (defaultBodySmall.color?.withOpacity(0.8) ?? Colors.grey[600]) : defaultBodyMedium.color,
    );
    final TextStyle valueStyle = defaultBodyMedium;

    return Padding(
      padding: EdgeInsets.only(
          left: isSubValue ? 24.0 : 8.0, // Indent sub-values (calculation lines)
          top: isSubValue ? 2.0 : 4.0,
          bottom: isSubValue ? 2.0 : 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSubValue && label.isNotEmpty)
            SizedBox(
              width: 150, // Consistent width for primary labels
              child: Text(label, style: labelStyle),
            ),
          if (!isSubValue && label.isNotEmpty) const SizedBox(width: 8),
          Expanded(
            child: Text(
              // If it's a sub-value (like the formula with numbers) and has a "label" (which is actually the formula string here),
              // then concatenate. Otherwise, just show the value.
              isSubValue && label.isNotEmpty ? label + value : value,
              style: isSubValue ? valueStyle.copyWith(fontWeight: FontWeight.w500) : valueStyle,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedBreakdownSection(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    // Fallback text styles
    final TextStyle sectionTitleStyle = textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: theme.primaryColorDark) ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    final TextStyle subHeadingStyle = textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold) ?? textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 13) ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

    final double investedAmount = double.tryParse(_investedAmountController.text) ?? 0.0;
    final double annualRatePercent = double.tryParse(_annualRateController.text) ?? 0.0;
    final int months = int.tryParse(_monthsController.text) ?? 0;

    if (_monthlyDividend == null || _totalDividend == null) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      color: theme.cardTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: theme.dividerColor.withOpacity(0.5))
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calculation Breakdown:',
              style: sectionTitleStyle,
            ),
            const SizedBox(height: 16),

            Text('Inputs Used:', style: subHeadingStyle),
            _buildDetailRow(context, 'Invested Amount:', _currencyFormatter.format(investedAmount)),
            _buildDetailRow(context, 'Annual Dividend Rate:', '$annualRatePercent%'),
            _buildDetailRow(context, 'Number of Months:', '$months'),
            const SizedBox(height: 16), // Increased spacing

            Text('Monthly Dividend Formula:', style: subHeadingStyle),
            _buildDetailRow(context, '', '(Rate / 12) × Invested Fund', isFormula: true),
            _buildDetailRow(context, '', '($annualRatePercent% / 12) × ${_currencyFormatter.format(investedAmount)} = ${_currencyFormatter.format(_monthlyDividend!)}', isSubValue: true),
            const SizedBox(height: 16), // Increased spacing

            Text('Total Dividend Formula:', style: subHeadingStyle),
            _buildDetailRow(context, '', 'Monthly Dividend × Number of Months', isFormula: true),
            _buildDetailRow(context, '', '${_currencyFormatter.format(_monthlyDividend!)} × $months = ${_currencyFormatter.format(_totalDividend!)}', isSubValue: true),
          ],
        ),
      ),
    );
  }
}