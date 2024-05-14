// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class NormalIconButton extends StatelessWidget {
  NormalIconButton({
    super.key,
    required this.icone,
    required this.onPress,
    this.label = "",
    this.width,
  });

  final IconData icone;
  final Function onPress;
  late double? width;
  final String label;

  @override
  Widget build(BuildContext context) {
    width ??= MediaQuery.of(context).size.width / 3;

    final ButtonStyle style = IconButton.styleFrom(
      backgroundColor: Colors.white,
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
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 40,
            width: width,
            child: IconButton(
              onPressed: () => onPress.call(),
              style: style,
              icon: Icon(
                icone,
                color: Colors.grey,
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
