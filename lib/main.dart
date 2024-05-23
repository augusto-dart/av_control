import 'package:av_control/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl_browser.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Utils/theme.dart' as tema;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await findSystemLocale();
  runApp(const AvControlApp());
}

class AvControlApp extends StatelessWidget {
  const AvControlApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Intl.defaultLocale = 'pt_BR';
    return MaterialApp(
      title: 'AV Control',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: tema.lighTheme,
      darkTheme: tema.darkTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      locale: const Locale('pt', 'BR'),
      home: LoginPage(),
    );
  }
}
