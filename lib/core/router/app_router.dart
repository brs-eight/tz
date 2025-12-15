import 'package:go_router/go_router.dart';
import 'package:tz/presentation/pages/home/home_page.dart';
import 'package:tz/presentation/pages/onboarding/onboarding_page.dart';
import 'package:tz/presentation/pages/paywall/paywall_page.dart';
import '../constants/route_constants.dart';

class AppRouter {
  static GoRouter router(String initialLocation) => GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: RouteConstants.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: RouteConstants.paywall,
        builder: (context, state) => const PaywallPage(),
      ),
      GoRoute(
        path: RouteConstants.home,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
