import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hm_help/src/components/tiposDeCategoria.dart';

class ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          enableInfiniteScroll: false,
          reverse: false,
          viewportFraction: 0.86,
          height: 230.0),
      items: <Widget>[
        TipoCategoria(),
        TipoCategoria2(),
        TipoCategoria3(),
      ],
    );
  }
}
