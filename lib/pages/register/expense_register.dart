// ignore_for_file: must_be_immutable

import 'package:av_control/Components/buttons/primary_button.dart';
import 'package:av_control/Components/fields/combo_box.dart';
import 'package:av_control/Components/fields/field.dart';
import 'package:av_control/Components/fields/field_type.dart';
import 'package:av_control/Utils/util.dart';
import 'package:av_control/models/bloc/cards/cards_bloc.dart';
import 'package:av_control/models/bloc/expense/expense_bloc.dart';
import 'package:av_control/models/cards.dart';
import 'package:av_control/models/enums.dart';
import 'package:av_control/models/expense.dart';
import 'package:av_control/services/cards_service.dart';
import 'package:av_control/services/expense_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ExpenseRegister extends StatefulWidget {
  const ExpenseRegister({
    super.key,
    required this.cartoes,
    this.expense,
  });

  final Expense? expense;
  final List<Cards> cartoes;

  @override
  State<ExpenseRegister> createState() => _ExpenseRegisterState();
}

class _ExpenseRegisterState extends State<ExpenseRegister> {
  final form = FormGroup({
    'description': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    'category': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    'card': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    'date': FormControl<DateTime>(
      validators: [
        Validators.required,
      ],
    ),
    'value': FormControl<double>(
      validators: [
        Validators.required,
      ],
    ),
  });
  final CardsService cardsService = CardsService();
  final ExpenseService service = ExpenseService();

  // final Expense? expense;
  // final List<Cards> cards;

  late Expense newExpense;
  late List<DropdownMenuItem> cartoes = [];

  // ExpenseRegister({
  //   super.key,
  //   required this.cards,
  //   this.expense,
  // });

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < cartoes.length; i++) {
      cartoes.add(
        DropdownMenuItem(
          value: widget.cartoes[i].id,
          child: Text(
            widget.cartoes[i].descricao,
          ),
        ),
      );
    }
    final double width = MediaQuery.of(context).size.width - 50;
    Cards selectedCard;
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
                    "Nova Despesa",
                    style: GoogleFonts.lato(),
                  ),
                  const AvField(
                    controlName: 'description',
                    hintText: 'Descrição',
                    requiredText: 'Informe a Descrição da Despesa',
                  ),
                  const AvField(
                    controlName: 'category',
                    hintText: 'Categoria',
                    requiredText: 'Informe a Categoria da Despesa',
                  ),
                  AvCombobox(
                    data: cartoes,
                    label: 'Cartão',
                    hintText: 'Cartão',
                    controlName: 'card',
                  ),
                  const AvField(
                    controlName: 'date',
                    hintText: 'Data',
                    tipo: FieldType.date,
                  ),
                  const AvField(
                    controlName: 'value',
                    hintText: 'Valor',
                  ),
                  PrimaryButton(
                    texto: 'Salvar',
                    icone: Icons.done,
                    parentWidth: width,
                    onPress: () => {
                      newExpense = Expense(
                        tipo: ExpenseType.expense,
                        data: Timestamp.fromDate(
                          form.control('date').value as DateTime,
                        ),
                        descricao: form.control('description').value,
                        categoria: form.control('category').value,
                        cartao: form.control('card').value,
                        valor: form.control('value').value,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                      ),
                      service.addExpense(newExpense).then(
                            (value) => {
                              Utils.showSucessMessage(
                                context,
                                'Despesa salva com sucesso!',
                              ),
                              selectedCard = widget.cartoes
                                  .where((cartao) =>
                                      cartao.id == newExpense.cartao)
                                  .first,
                              context
                                  .read<ExpenseBloc>()
                                  .add(AddExpense(expense: newExpense)),
                              selectedCard.valor += newExpense.valor,
                              cardsService.updateCard(selectedCard),
                              context
                                  .read<CardsBloc>()
                                  .add(UpdateCard(card: selectedCard)),
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
