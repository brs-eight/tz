import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tz/presentation/pages/paywall/controller/paywall_cubit.dart';
import '../../../core/constants/route_constants.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaywallCubit, PaywallState>(
      listener: (context, state) {
        // TODO i dont like it
        if (state is PaywallBuyed) {
          context.go(RouteConstants.home);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Icon(
                  Icons.rocket_launch,
                  size: 100,
                  color: Colors.deepPurple,
                ),
                const SizedBox(height: 32),
                const Text(
                  'Welcome to the App',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Discover amazing features and boost your productivity with our tools.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pushReplacement(RouteConstants.paywall);
                    },
                    child: const Text('Continue'),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
