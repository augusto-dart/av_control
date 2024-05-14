import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.texto,
    required this.icone,
    required this.onPress,
  });

  final String texto;
  final Icon icone;

  final Function onPress;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 48,
        width: MediaQuery.of(context).size.width / 1.3,
        child: ElevatedButton.icon(
          onPressed: () => onPress.call(),
          style: style,
          icon: icone,
          label: Text(texto),
        ),
      ),
    );
  }
}
