// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class NormalIconButton extends StatelessWidget {
  NormalIconButton({
    super.key,
    required this.icone,
    required this.onPress,
    required this.parentWidth,
    this.label = "",
    this.corBotao = Colors.grey,
    this.width,
  });

  final IconData icone;
  final Function onPress;
  late double? width;
  final double parentWidth;
  final String label;
  final Color corBotao;

  @override
  Widget build(BuildContext context) {
    width ??= parentWidth / 3.5;

    final ButtonStyle style = IconButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: corBotao, width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 40,
            width: width,
            child: IconButton(
              onPressed: () => onPress.call(),
              style: style,
              icon: Icon(
                icone,
                color: corBotao,
              ),
            ),
          ),
          Visibility(
            visible: label.isNotEmpty,
            maintainState: false,
            maintainSize: false,
            child: Text(
              label,
            ),
          ),
        ],
      ),
    );
  }
}
