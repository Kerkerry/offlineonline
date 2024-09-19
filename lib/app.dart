import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offlineapp/config/theme/app_theme.dart';
import 'package:offlineapp/core/dependency_injection.dart/di.dart';
import 'package:offlineapp/core/dependency_injection.dart/di_ex.dart';
import 'package:offlineapp/features/home/presentation/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: BlocProvider(
        create: (context) => di<HomeBloc>()..add(const HomeCallProductsEvent()),
        child: const HomePage(),
      ),
    );
  }
}
