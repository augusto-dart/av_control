import 'package:av_control/Components/buttons/icon_button.dart';
import 'package:av_control/Components/buttons/normal_button.dart';
import 'package:av_control/models/bloc/expense_bloc.dart';
import 'package:av_control/models/cards.dart';
import 'package:av_control/pages/auth/login_page.dart';
import 'package:av_control/pages/home/carousel.dart';
import 'package:av_control/pages/home/last_expenses.dart';
import 'package:av_control/pages/home/loading_page.dart';
import 'package:av_control/pages/register/expense_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        goToLogin(context);
      }
    });

    final User usuarioAtual = FirebaseAuth.instance.currentUser!;
    final GlobalKey<SliderDrawerState> drawerKey =
        GlobalKey<SliderDrawerState>();

    final List<Cards> cartoes = [
      Cards(descricao: 'Nubank', valor: 1350),
      Cards(descricao: 'Bradesco', valor: 2350),
    ];

    late double valorTotal = cartoes
        .map((cartao) => cartao.valor)
        .reduce((value, element) => value + element);

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
        child: BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, state) {
            if (state is ExpenseInitial) {
              return const LoadingPage();
            }
            if (state is ExpenseLoaded) {
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
                  Carousel(cartoes: cartoes),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NormalIconButton(
                        icone: MdiIcons.finance,
                        onPress: () => {},
                        width: MediaQuery.of(context).size.width / 6,
                        label: "Nova Receita",
                      ),
                      NormalIconButton(
                        icone: MdiIcons.chartBellCurve,
                        onPress: () => {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const ExpenseRegister();
                            },
                          ),
                        },
                        width: MediaQuery.of(context).size.width / 6,
                        label: "Nova Despesa",
                      ),
                      NormalIconButton(
                        icone: MdiIcons.creditCardPlusOutline,
                        onPress: () => {},
                        width: MediaQuery.of(context).size.width / 6,
                        label: "Cartões",
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
                    child: LastExpenses(expenses: state.expenses),
                  ),
                ],
              );
            } else {
              return const Text("Deu ruim!");
            }
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
