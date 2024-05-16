import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({
    super.key,
  });

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      value: 100.0,
    )..repeat();

    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
          scale: _controller.value,
          child: Image.asset(
            "assets/images/logo_full_orange.png",
          ),
        );
      },
    );
  }
}
