import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final TextStyle estiloTexto = GoogleFonts.readexPro(
      color: Colors.white,
      fontSize: 14.0,
    );

    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: estiloTexto,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 48,
        width: MediaQuery.of(context).size.width / 1.3,
        child: ElevatedButton.icon(
          onPressed: () => onPress.call(),
          style: style,
          icon: icone,
          label: Text(
            texto,
            style: estiloTexto,
          ),
        ),
      ),
    );
  }
}
