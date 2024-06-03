import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RemoveButton extends StatelessWidget {
  const RemoveButton({
    super.key,
    required this.texto,
    required this.icone,
    required this.onPress,
    required this.parentWidth,
  });

  final String texto;
  final IconData icone;
  final Function onPress;
  final double parentWidth;

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
      backgroundColor: Theme.of(context).colorScheme.error,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 48,
        width: parentWidth,
        child: ElevatedButton.icon(
          onPressed: () => onPress.call(),
          style: style,
          icon: Icon(
            icone,
            color: Colors.white,
          ),
          label: Text(
            texto,
            style: estiloTexto,
          ),
        ),
      ),
    );
  }
}
