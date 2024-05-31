// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:av_control/Components/buttons/icon_button.dart';
import 'package:av_control/models/bloc/expense_bloc.dart';
import 'package:av_control/models/enums.dart';
import 'package:av_control/models/expense.dart';
import 'package:av_control/pages/auth/login_page.dart';
import 'package:av_control/pages/home/Components/Menu/menu.dart';
import 'package:av_control/pages/home/Components/home_top_widget.dart';
import 'package:av_control/pages/home/Components/last_expenses.dart';
import 'package:av_control/pages/register/card_register.dart';
import 'package:av_control/pages/register/expense_register.dart';
import 'package:av_control/services/expense_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();
  final ExpenseService service = ExpenseService();

  final List<Expense> fakeExpenses = List.generate(
    10,
    (index) {
      return Expense(
        cartao: '',
        categoria: '',
        data: Timestamp.now(),
        descricao: '',
        tipo: ExpenseType.all,
        userId: '',
        valor: 0.0,
      );
    },
  );

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    (context.read<ExpenseBloc>()).add(const ClearExpenses());
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        goToLogin(context);
      }
    });

    double height = MediaQuery.of(context).size.height - 415;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder(
        future: service.getExpenses(),
        builder: (context, build) {
          if (build.hasData) {
            context.read<ExpenseBloc>().add(
                  AddExpenses(expenses: build.data!),
                );
          }
          return SliderDrawer(
            appBar: SliderAppBar(
              appBarColor: Theme.of(context).colorScheme.surface,
              title: const Text(""),
            ),
            isCupertino: true,
            isDraggable: true,
            splashColor: Theme.of(context).colorScheme.primary,
            key: drawerKey,
            slider: const MenuWidget(),
            child: Container(
              color: Theme.of(context).colorScheme.surfaceContainer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<ExpenseBloc, ExpenseState>(
                    builder: (context, state) {
                      if (state is ExpenseLoaded) {
                        List<Expense> expenses = state.expenses;
                        return HomeTopWidget(expenses: expenses);
                      } else {
                        return Skeletonizer(
                          enabled: true,
                          child: HomeTopWidget(expenses: const []),
                        );
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NormalIconButton(
                        icone: MdiIcons.finance,
                        width: width / 4,
                        parentWidth: width,
                        label: "Nova Receita",
                        onPress: () => {},
                      ),
                      NormalIconButton(
                        icone: MdiIcons.chartBellCurve,
                        width: width / 4,
                        parentWidth: width,
                        label: "Nova Despesa",
                        onPress: () => {
                          showModalBottomSheet(
                            elevation: 8.0,
                            isDismissible: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                              ),
                            ),
                            context: context,
                            builder: (context) {
                              return const ExpenseRegister();
                            },
                          ),
                        },
                      ),
                      NormalIconButton(
                        icone: MdiIcons.creditCardPlusOutline,
                        width: width / 4,
                        parentWidth: width,
                        label: "Cartões",
                        onPress: () => {
                          showModalBottomSheet(
                            elevation: 8.0,
                            isDismissible: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                              ),
                            ),
                            context: context,
                            builder: (context) {
                              return const CardRegister();
                            },
                          ),
                        },
                      ),
                    ],
                  ),
                  BlocBuilder<ExpenseBloc, ExpenseState>(
                    builder: (context, state) {
                      if (state is ExpenseLoaded) {
                        return ConstrainedBox(
                          constraints: BoxConstraints.tight(
                            Size(
                              MediaQuery.of(context).size.width,
                              height,
                            ),
                          ),
                          child: LastExpenses(expenses: state.expenses),
                        );
                      } else {
                        return Skeletonizer(
                          enabled: true,
                          child: ConstrainedBox(
                            constraints: BoxConstraints.tight(
                              Size(
                                MediaQuery.of(context).size.width,
                                height,
                              ),
                            ),
                            child: LastExpenses(expenses: fakeExpenses),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void goToLogin(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 250),
      () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      },
    );
  }
}
