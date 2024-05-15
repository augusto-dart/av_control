import 'package:av_control/Components/buttons/primary_button.dart';
import 'package:av_control/Components/fields/text_field.dart';
import 'package:av_control/Utils/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreateUserPage extends StatelessWidget with Utils {
  CreateUserPage({super.key});

  createUserWithEmail(BuildContext context) {
    String email = form.control('email').value;
    String password = form.control('password').value;
    String confirmPassword = form.control('confirmPassword').value;

    if (password.length < 6) {
      showErrorMessage(context, 'Senha deve possuir no mínimo 6 caracteres!');
      return;
    }

    if (password == confirmPassword) {
      try {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: email,
              password: password,
            )
            .then(
              (value) => createUser(context, value),
            );
      } on FirebaseAuthException catch (e) {
        showErrorMessage(context, e.message!);
      }
    } else {
      showErrorMessage(context, 'Senhas não conferem!');
    }
  }

  createUser(BuildContext context, UserCredential credential) {
    String nome = form.control('name').value;
    credential.user!.updateDisplayName(nome);

    showSucessMessage(context, 'Usuário criado com sucesso!');
    Navigator.pop(context);
  }

  final form = FormGroup({
    'name': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
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
    'confirmPassword': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar conta"),
        elevation: 0,
        centerTitle: true,
      ),
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
              width: MediaQuery.of(context).size.width / 1.3,
              child: Card(
                color: Colors.white,
                elevation: 16,
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
                        child: Image.asset(
                          '/images/logo_green.png',
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                      ),
                      const AvTextField(
                        controlName: 'name',
                        hintText: 'Nome',
                        requiredText: 'Informe seu Nome',
                      ),
                      const AvTextField(
                        controlName: 'email',
                        hintText: 'E-mail',
                        requiredText: 'Informe seu Email',
                      ),
                      const AvTextField(
                        controlName: 'password',
                        hintText: 'Senha',
                        requiredText: 'Informe sua Senha',
                        obscure: true,
                      ),
                      const AvTextField(
                        controlName: 'confirmPassword',
                        hintText: 'Confirmar Senha',
                        requiredText: 'Confirme sua Senha',
                        obscure: true,
                      ),
                      ReactiveFormConsumer(
                        builder: (context, formGroup, child) => PrimaryButton(
                          icone: const Icon(Icons.login),
                          texto: "Criar",
                          onPress: () => createUserWithEmail(context),
                        ),
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
}
