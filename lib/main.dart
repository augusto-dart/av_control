import 'package:av_control/Utils/app_bloc_observer.dart';
import 'package:av_control/Utils/theme_cubit.dart';
import 'package:av_control/models/bloc/cards/cards_bloc.dart';
import 'package:av_control/models/bloc/expense/expense_bloc.dart';
import 'package:av_control/pages/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Intl.defaultLocale = 'pt_BR';

  final auth = FirebaseAuth.instanceFor(
    app: Firebase.app(),
  );
  await auth.setPersistence(Persistence.NONE);

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
          create: (_) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => ExpenseBloc()
            ..add(
              const LoadExpense(expenses: []),
            ),
        ),
        BlocProvider(
          create: (context) => CardsBloc()
            ..add(
              const LoadCards(cards: []),
            ),
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
