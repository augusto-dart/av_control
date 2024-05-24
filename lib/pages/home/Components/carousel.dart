import 'package:av_control/models/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class Carousel extends StatelessWidget {
  const Carousel({
    super.key,
    required this.cartoes,
  });

  final List<Cards> cartoes;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > 500
        ? 400
        : MediaQuery.of(context).size.width;

    return FlutterCarousel(
      options: CarouselOptions(
        height: 200.0,
        showIndicator: true,
        slideIndicator: const CircularSlideIndicator(),
      ),
      items: cartoes.map((cartao) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                color: Color(cartao.cor),
                shadowColor: Color(cartao.cor),
                elevation: 8.0,
                child: Container(
                  width: width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartao.descricao,
                            style: const TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                            ),
                          ),
                          Image.asset(
                            'assets/images/logo_orange.png',
                            width: 50,
                          ),
                        ],
                      ),
                      Divider(
                        height: 15,
                        color: Color(cartao.cor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "R\$ ${cartao.valor.toString()}",
                            style: const TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
