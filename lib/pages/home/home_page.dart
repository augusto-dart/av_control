import 'dart:async';

import 'package:av_control/Components/buttons/icon_button.dart';
import 'package:av_control/Components/buttons/normal_button.dart';
import 'package:av_control/models/cards.dart';
import 'package:av_control/models/expense.dart';
import 'package:av_control/pages/auth/login_page.dart';
import 'package:av_control/pages/home/carousel.dart';
import 'package:av_control/pages/home/last_expenses.dart';
import 'package:av_control/pages/home/loading_page.dart';
import 'package:av_control/pages/register/card_register.dart';
import 'package:av_control/pages/register/expense_register.dart';
import 'package:av_control/services/expense_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User usuarioAtual = FirebaseAuth.instance.currentUser!;
  final GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();
  final ExpenseService service = ExpenseService();

  final List<Cards> cards = [
    Cards(
      descricao: 'Nubank',
      cor: Colors.purple.value,
      userId: FirebaseAuth.instance.currentUser!.uid,
    ),
    Cards(
      descricao: 'Bradesco',
      cor: Colors.red.value,
      userId: FirebaseAuth.instance.currentUser!.uid,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        goToLogin(context);
      }
    });

    String imageUrl = usuarioAtual.photoURL ?? '';
    String nome = usuarioAtual.displayName!;
    double height = MediaQuery.of(context).size.height - 405;

    return Scaffold(
      body: SliderDrawer(
        key: drawerKey,
        appBar: const SliderAppBar(
          appBarColor: Colors.white,
          title: Text(""),
        ),
        slider: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 30, // Adjust the radius for the size you want
                  backgroundImage:
                      imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                  child: imageUrl.isEmpty
                      ? Text(
                          nome.substring(0, 1),
                          style: const TextStyle(
                            fontSize: 32.0,
                          ),
                        )
                      : null,
                ),
              ],
            ),
            Text(
              nome,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const Divider(
              height: 8.0,
            ),
            NormalButton(
              icone: MdiIcons.faceMan,
              onPress: () {},
              texto: 'Meu Perfil',
              autoSize: true,
            ),
            TextButton.icon(
              onPressed: () => _doLogout(context),
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
              ),
              icon: Icon(
                MdiIcons.logout,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: const Text("Sair"),
            ),
          ],
        ),
        child: StreamBuilder<List<Expense>>(
          stream: service.getExpenses(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Expense>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingPage();
            }
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                List<Expense> expenses = snapshot.data!;
                double valorTotal =
                    expenses.fold<double>(0, (sum, item) => sum + item.valor);

                for (Cards card in cards) {
                  card.setValor(expenses
                      .where((element) => element.cartao == card.descricao)
                      .fold(0, (sum, item) => sum + item.valor));
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Valor Total',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'R\$ $valorTotal',
                        style: const TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    Carousel(cartoes: cards),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        NormalIconButton(
                          icone: MdiIcons.finance,
                          width: MediaQuery.of(context).size.width / 4,
                          label: "Nova Receita",
                          onPress: () => {},
                        ),
                        NormalIconButton(
                          icone: MdiIcons.chartBellCurve,
                          width: MediaQuery.of(context).size.width / 4,
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
                          width: MediaQuery.of(context).size.width / 4,
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
                    ConstrainedBox(
                      constraints: BoxConstraints.tight(
                        Size(
                          MediaQuery.of(context).size.width,
                          height,
                        ),
                      ),
                      child: LastExpenses(expenses: expenses),
                    ),
                  ],
                );
              } else {
                return Text(snapshot.data.toString());
              }
            }
            return Text(snapshot.connectionState.name);
          },
        ),
      ),
    );
  }

  _doLogout(BuildContext context) async {
    FirebaseAuth.instance.signOut();
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
