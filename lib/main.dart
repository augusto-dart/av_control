import 'dart:async';

import 'package:av_control/Utils/app_bloc_observer.dart';
import 'package:av_control/Utils/theme_cubit.dart';
import 'package:av_control/models/bloc/expense_bloc.dart';
import 'package:av_control/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Intl.defaultLocale = 'pt_BR';

  Bloc.observer = const AppBlocObserver();
  runApp(const AvControlApp());
}

class AvControlApp extends StatelessWidget {
  const AvControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExpenseBloc()
            ..add(
              const LoadExpense(expenses: []),
            ),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) {
          return MaterialApp(
            title: 'AV Control',
            debugShowCheckedModeBanner: false,
            theme: theme,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: const [Locale('pt', 'BR')],
            locale: const Locale('pt', 'BR'),
            home: LoginPage(),
          );
        },
      ),
    );
  }
}
