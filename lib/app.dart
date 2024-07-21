
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feature/settings/presentation/providers/setting_provider.dart';
import 'feature/splash/presentation/pages/splash_page.dart';
import 'providers.dart';
import 'shared/app_router.dart';


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.list,
      child: Builder(
        builder: (context) {
          final provider = Provider.of<SettingProvider>(context);
          final isDarkMode = provider.isDarkMode ? ThemeMode.dark : ThemeMode.light;
          return MaterialApp(
            title: 'Cat Breeds',
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                surfaceTintColor: Colors.white,
                color: Colors.white
              ),
              scaffoldBackgroundColor: Colors.white,
              secondaryHeaderColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffffbc7a)),
              useMaterial3: true,
            ),
            darkTheme: ThemeData.dark(
              useMaterial3: true,
            ).copyWith(
              brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffffbc7a)),
              appBarTheme:  const AppBarTheme(
                surfaceTintColor: Color.fromARGB(255, 20, 19, 19),
                color: Color.fromARGB(255, 20, 19, 19),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: isDarkMode,
            home: const SplashPage(),
            onGenerateRoute: (settings) => AppRouter.appRouter.matchRoute(
              settings.name!,
              routeSettings: settings,
            ),
          );
        }
      ),
    );
  }
}