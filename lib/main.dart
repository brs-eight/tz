import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tz/presentation/pages/paywall/controller/paywall_cubit.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'data/repository/hive_local_storage_repository.dart';
import 'core/constants/route_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Initialize Repository
  final localRepo = HiveLocalStorageRepository();
  await localRepo.init();

  final subscription = await localRepo.getSubscription();
  final initialLocation = subscription != null ? RouteConstants.home : RouteConstants.onboarding;

  runApp(MainApp(localRepo: localRepo, initialLocation: initialLocation));
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.localRepo,
    required this.initialLocation,
  });

  final HiveLocalStorageRepository localRepo;
  final String initialLocation;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaywallCubit(localStorageRepository: localRepo),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.createRouter(initialLocation),
      ),
    );
  }
}
