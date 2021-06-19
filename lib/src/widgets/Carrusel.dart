import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hm_help/src/widgets/tiposDeCategoria.dart';

class ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          aspectRatio: 16 / 9,
          autoPlay: true,
          enableInfiniteScroll: false,
          reverse: false,
          viewportFraction: 0.8,
          height: 220),
      items: <Widget>[
        tipoCategoria(),
        tipoCategoria2(),
        tipoCategoria3(),
      ],
    );
  }
}
