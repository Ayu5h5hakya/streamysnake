import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'engine.dart';

class TetrisBoard extends StatefulWidget {
  final double extent;
  const TetrisBoard({Key? key, required this.extent}) : super(key: key);

  @override
  State<TetrisBoard> createState() => _TetrisBoardState();
}

class _TetrisBoardState extends State<TetrisBoard> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      heightFactor: 0.75,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: widget.extent,
        ),
        itemBuilder: (_, index) => DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        itemCount: 648,
      ),
    );
  }
}
