import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tz/presentation/pages/paywall/controller/paywall_cubit.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'data/repository/hive_local_storage_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Initialize Repository
  final localRepo = HiveLocalStorageRepository();

  // TODO add getit service locator (if we had more than one repository)
  await localRepo.init();

  // TODO Implement Logger later (talker or any, but unecesary fr now)
  runApp(MainApp(localRepo: localRepo));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.localRepo});

  final HiveLocalStorageRepository localRepo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PaywallCubit(localStorageRepository: localRepo)..checkSubscription(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
