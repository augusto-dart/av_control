import 'package:av_control/Components/buttons/primary_button.dart';
import 'package:av_control/Components/fields/field.dart';
import 'package:av_control/Components/fields/field_type.dart';
import 'package:av_control/Utils/util.dart';
import 'package:av_control/models/bloc/expense/expense_bloc.dart';
import 'package:av_control/models/enums.dart';
import 'package:av_control/models/expense.dart';
import 'package:av_control/services/expense_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReceiveRegister extends StatefulWidget {
  const ReceiveRegister({super.key});

  @override
  State<ReceiveRegister> createState() => _ReceiveRegisterState();
}

class _ReceiveRegisterState extends State<ReceiveRegister> {
  final form = FormGroup(
    {
      'description': FormControl<String>(
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
    },
  );
  final ExpenseService service = ExpenseService();
  late Expense newReceive;

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
                    "Nova Receita",
                    style: GoogleFonts.lato(),
                  ),
                  const AvField(
                    controlName: 'description',
                    hintText: 'Descrição',
                    requiredText: 'Informe a Descrição da Receita',
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
                      newReceive = Expense(
                        tipo: ExpenseType.receive,
                        data: Timestamp.fromDate(
                          form.control('date').value as DateTime,
                        ),
                        descricao: form.control('description').value,
                        categoria: '',
                        cartao: '',
                        valor: form.control('value').value,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                      ),
                      service.addExpense(newReceive).then(
                            (value) => {
                              Utils.showSucessMessage(
                                context,
                                'Receita salva com sucesso!',
                              ),
                              context.read<ExpenseBloc>().add(
                                    AddExpense(expense: newReceive),
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
