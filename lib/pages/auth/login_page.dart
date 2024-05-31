// ignore_for_file: avoid_print, use_build_context_synchronously, must_be_immutable

import 'package:av_control/Components/buttons/icon_button.dart';
import 'package:av_control/Components/buttons/primary_button.dart';
import 'package:av_control/Components/fields/field.dart';
import 'package:av_control/Components/fields/field_type.dart';
import 'package:av_control/Utils/util.dart';
import 'package:av_control/auth/auth_with_apple.dart';
import 'package:av_control/auth/auth_with_google.dart';
import 'package:av_control/pages/auth/create_user_page.dart';
import 'package:av_control/pages/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final form = FormGroup({
    'email': FormControl<String>(
      validators: [
        Validators.required,
        Validators.email,
      ],
    ),
    'password': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  });

  final TextStyle textStyle = const TextStyle(
    color: Colors.grey,
    fontSize: 12.0,
  );
  late bool creatingUser = false;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null && !creatingUser) {
        goToHome(context);
      }
    });
    final double cardWidth = Utils.largeScreenSize(context)
        ? MediaQuery.of(context).size.width / 4
        : MediaQuery.of(context).size.width / 1.3;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.tertiary,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: cardWidth,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ReactiveForm(
                  formGroup: form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              '/images/logo_gray_orange.png',
                              width: cardWidth / 2,
                            ),
                            Text(
                              "Control",
                              style: GoogleFonts.rufina(
                                fontSize: 24.0,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      const AvField(
                        controlName: 'email',
                        hintText: 'E-mail',
                        requiredText: 'Informe seu Email',
                      ),
                      const AvField(
                        controlName: 'password',
                        hintText: 'Senha',
                        requiredText: 'Informe sua Senha',
                        tipo: FieldType.password,
                      ),
                      ReactiveFormConsumer(
                        builder: (context, formGroup, child) => PrimaryButton(
                          icone: Icons.done,
                          texto: "Entrar",
                          onPress: () => _doLogin(context),
                          parentWidth: cardWidth,
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Ou acesse com",
                              style: textStyle,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NormalIconButton(
                            icone: MdiIcons.google,
                            onPress: () => _loginGoogle(context),
                            parentWidth: cardWidth,
                          ),
                          NormalIconButton(
                            icone: MdiIcons.apple,
                            onPress: () => _loginApple(context),
                            parentWidth: cardWidth,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "Ainda não possui uma conta?",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 12.0),
                            ),
                            onPressed: () => _criarConta(context),
                            child: const Text("Criar Conta"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _doLogin(BuildContext context) async {
    creatingUser = false;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: form.control("email").value,
        password: form.control("password").value,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        Utils.displayToast(context, "Email ou senha inválidos!");
      } else {
        print(e.code);
        print(e.message);
      }
    }
  }

  void _criarConta(BuildContext context) {
    creatingUser = true;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateUserPage(),
        maintainState: false,
      ),
    );
  }

  void _loginGoogle(BuildContext context) async {
    await signInWithGoogle();
  }

  void _loginApple(BuildContext context) async {
    await signInWithApple();
  }

  void goToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
