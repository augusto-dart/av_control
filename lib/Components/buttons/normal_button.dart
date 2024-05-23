import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  const NormalButton({
    super.key,
    required this.texto,
    required this.icone,
    required this.onPress,
    this.autoSize = false,
  });

  final String texto;
  final IconData icone;
  final Function onPress;
  final bool autoSize;

  @override
  Widget build(BuildContext context) {
    final TextStyle estiloTexto = Theme.of(context).textTheme.bodyMedium!;
    final double? width =
        autoSize ? null : MediaQuery.of(context).size.width / 3;

    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: estiloTexto,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        width: width,
        child: ElevatedButton.icon(
          onPressed: () => onPress.call(),
          style: style,
          icon: Icon(
            icone,
            color: Colors.grey,
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
