import 'package:av_control/Components/buttons/primary_button.dart';
import 'package:av_control/Components/fields/field.dart';
import 'package:av_control/Components/fields/field_type.dart';
import 'package:av_control/Utils/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreateUserPage extends StatelessWidget {
  CreateUserPage({super.key});

  createUserWithEmail(BuildContext context) {
    String email = form.control('email').value;
    String password = form.control('password').value;
    String confirmPassword = form.control('confirmPassword').value;

    if (password.length < 6) {
      Utils.showErrorMessage(
          context, 'Senha deve possuir no mínimo 6 caracteres!');
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
        Utils.showErrorMessage(context, e.message!);
      }
    } else {
      Utils.showErrorMessage(context, 'Senhas não conferem!');
    }
  }

  createUser(BuildContext context, UserCredential credential) {
    String nome = form.control('name').value;
    credential.user!.updateDisplayName(nome);

    Utils.showSucessMessage(context, 'Usuário criado com sucesso!');
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
    final double cardWidth = Utils.largeScreenSize(context)
        ? MediaQuery.of(context).size.width / 4
        : MediaQuery.of(context).size.width / 1.3;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar conta"),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
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
                                'assets//images/logo_gray_orange.png',
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
                          controlName: 'name',
                          hintText: 'Nome',
                          requiredText: 'Informe seu Nome',
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
                        const AvField(
                          controlName: 'confirmPassword',
                          hintText: 'Confirmar Senha',
                          requiredText: 'Confirme sua Senha',
                          tipo: FieldType.password,
                        ),
                        ReactiveFormConsumer(
                          builder: (context, formGroup, child) => PrimaryButton(
                            icone: Icons.done,
                            texto: "Criar",
                            onPress: () => createUserWithEmail(context),
                            parentWidth: cardWidth,
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
      ),
    );
  }
}
