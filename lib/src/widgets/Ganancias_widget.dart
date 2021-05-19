import 'package:flutter/material.dart';
import 'package:hm_help/src/styles/Styles.dart';

class GananciasText extends StatelessWidget {
  GananciasText({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  final estilo = Styles().estilo;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        snapshot.data.toString(),
        style: estilo,
      ),
    );
  }
}
