import 'package:av_control/Utils/theme_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final User usuarioAtual = FirebaseAuth.instance.currentUser!;
    String imageUrl = usuarioAtual.photoURL ?? '';
    String nome = usuarioAtual.displayName!;

    return ListView(
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
        BlocBuilder<ThemeCubit, ThemeData>(
          builder: (context, state) {
            return Row(
              children: [
                Text(
                  "Mudar para tema ${state.brightness == Brightness.dark ? "Claro" : "Escuro"}",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                CupertinoSwitch(
                  value: state.brightness == Brightness.dark,
                  onChanged: (value) =>
                      context.read<ThemeCubit>().toggleTheme(),
                ),
              ],
            );
          },
        ),
        Divider(
          height: MediaQuery.of(context).size.height - 200,
          color: Theme.of(context).dividerColor,
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
    );
  }

  _doLogout(BuildContext context) async {
    FirebaseAuth.instance.signOut();
  }
}
