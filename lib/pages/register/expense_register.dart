import 'package:av_control/Components/buttons/primary_button.dart';
import 'package:av_control/Components/fields/text_field.dart';
import 'package:av_control/Utils/util.dart';
import 'package:av_control/models/bloc/expense_bloc.dart';
import 'package:av_control/models/expense.dart';
import 'package:av_control/services/expense_service.dart';
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

  late Expense newExpense;

  @override
  Widget build(BuildContext context) {
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
                  const AvTextField(
                    controlName: 'description',
                    hintText: 'Descrição',
                    requiredText: 'Informe a Descrição da Despesa',
                  ),
                  const AvTextField(
                    controlName: 'category',
                    hintText: 'Categoria',
                    requiredText: 'Informe a Categoria da Despesa',
                  ),
                  const AvTextField(
                    controlName: 'card',
                    hintText: 'Cartão',
                  ),
                  const AvTextField(
                    controlName: 'date',
                    hintText: 'Data',
                  ),
                  const AvTextField(
                    controlName: 'value',
                    hintText: 'Valor',
                  ),
                  PrimaryButton(
                    texto: 'Salvar',
                    icone: const Icon(Icons.done),
                    onPress: () => {
                      newExpense = Expense(
                        tipo: 1,
                        data: form.control('date').value,
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
                                    AddExpense(
                                      expense: newExpense,
                                    ),
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
