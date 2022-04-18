import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'engine.dart';
import 'tetromino/i_block.dart';

class Player extends StatelessWidget {
  final double boardWidth, boardHeight, extent;
  final VoidCallback? onBottomReached;
  Player({
    Key? key,
    required this.boardWidth,
    required this.boardHeight,
    required this.extent,
    this.onBottomReached,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: boardWidth,
        height: boardHeight,
        child: StreamBuilder<int>(
          stream: Engine.start(boardHeight ~/ extent),
          builder: ((context, snapshot) {
            return CustomPaint(
              painter: IBlock(
                width: extent,
                position: extent * (snapshot.data ?? 1),
                origin: const Point(0, 0),
              ),
            );
          }),
        ),
      ),
    );
  }
}
