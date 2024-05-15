import 'package:av_control/models/bloc/expense_bloc.dart';
import 'package:av_control/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AvControlApp());
}

class AvControlApp extends StatelessWidget {
  const AvControlApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExpenseBloc()..add(LoadExpense()),
        ),
      ],
      child: MaterialApp(
        title: 'AV Control',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: false,
          colorScheme: const ColorScheme.light(
            primary: Color.fromARGB(255, 25, 219, 138),
            secondary: Color.fromARGB(255, 25, 219, 138),
            tertiary: Color.fromARGB(255, 255, 161, 48),
          ),
        ),
        home: LoginPage(),
      ),
    );
  }
}
