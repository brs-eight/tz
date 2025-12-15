import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tz/presentation/pages/paywall/controller/paywall_cubit.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/theme/app_colors.dart';


// TODO make as stateless via putting all the logic into cubit
class PaywallPage extends StatefulWidget {
  const PaywallPage({super.key});

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  String _selectedPlan = 'year'; // 'month' or 'year'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Access'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            context.pushReplacement(RouteConstants.home);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Unlock Full Potential',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Get unlimited access to all features.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            _buildPlanOption(
              value: 'month',
              title: 'Monthly Subscription',
              price: '\$9.99 / month',
              subtitle: 'Pay as you go',
            ),
            const SizedBox(height: 16),
            _buildPlanOption(
              value: 'year',
              title: 'Yearly Subscription',
              price: '\$49.99 / year',
              subtitle: 'Save 58%',
              isBestValue: true,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Mock purchase
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Subscribed to $_selectedPlan plan!'),
                    ),
                  );
                  final cubit = context.read<PaywallCubit>();
                  // TODO add counter for buying more than month (3, 6 , 9 ,15 ...etc)
                  cubit.buySubscForMonth(
                    monthAmount: _selectedPlan == 'year' ? 12 : 1,
                  );
                  context.pushReplacement(RouteConstants.home);
                },
                child: Text(
                  _selectedPlan == 'year'
                      ? 'Start Yearly Plan'
                      : 'Start Monthly Plan',
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // TODO separate as diff widget, connect via cubit 
  Widget _buildPlanOption({
    required String value,
    required String title,
    required String price,
    String? subtitle,
    bool isBestValue = false,
  }) {
    final isSelected = _selectedPlan == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedPlan = value),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.05)
              : Colors.white,
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isBestValue) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'BEST VALUE',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(price, style: const TextStyle(fontSize: 14)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: isBestValue ? AppColors.success : Colors.grey,
                        fontWeight: isBestValue
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
