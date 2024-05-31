import 'package:av_control/Components/buttons/primary_button.dart';
import 'package:av_control/Components/fields/combo_box.dart';
import 'package:av_control/Components/fields/field.dart';
import 'package:av_control/Components/fields/field_type.dart';
import 'package:av_control/Utils/util.dart';
import 'package:av_control/models/bloc/expense_bloc.dart';
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
  const ExpenseRegister({super.key});

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
  final ExpenseService service = ExpenseService();
  final CardsService cardService = CardsService();

  late Expense newExpense;
  late List<DropdownMenuItem> cartoes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 50;
    _getCards().then(
      (cards) {
        for (int i = 0; i < cards.length; i++) {
          cartoes.add(
            DropdownMenuItem(
              value: cards[i],
              child: Text(
                cards[i],
              ),
            ),
          );
        }
      },
    );

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
                              context.read<ExpenseBloc>().add(
                                    AddExpense(expense: newExpense),
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

  Future<List<String>> _getCards() async {
    List<Cards> cards = await cardService.getCards();
    return cards.map((card) => card.descricao).toList();
  }
}
