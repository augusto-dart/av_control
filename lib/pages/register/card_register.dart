import 'package:av_control/Components/buttons/primary_button.dart';
import 'package:av_control/Components/fields/field.dart';
import 'package:av_control/Utils/util.dart';
import 'package:av_control/models/cards.dart';
import 'package:av_control/services/cards_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CardRegister extends StatefulWidget {
  const CardRegister({super.key});

  @override
  State<CardRegister> createState() => _CardRegisterState();
}

class _CardRegisterState extends State<CardRegister> {
  final form = FormGroup({
    'description': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    'color': FormControl<int>(
      validators: [
        Validators.required,
      ],
    ),
  });
  final CardsService service = CardsService();

  late Cards newCard;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 50;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  MdiIcons.arrowLeft,
                  color: Colors.grey,
                ),
              ),
            ),
            ReactiveForm(
              formGroup: form,
              child: Column(
                children: [
                  Text(
                    "Novo Cartão",
                    style: GoogleFonts.lato(),
                  ),
                  const AvField(
                    controlName: 'description',
                    hintText: 'Descrição',
                    requiredText: 'Informe a Descrição do Cartão',
                  ),
                  PrimaryButton(
                    texto: 'Salvar',
                    icone: Icons.done,
                    parentWidth: width,
                    onPress: () => {
                      newCard = Cards(
                        descricao: form.control('description').value,
                        valor: 0.0,
                        cor: Colors.amber.value,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                      ),
                      service.addCard(newCard).then(
                            (value) => {
                              Utils.showSucessMessage(
                                context,
                                'Cartão salvo com sucesso!',
                              ),
                              Navigator.of(context).pop(),
                            },
                          ),
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
