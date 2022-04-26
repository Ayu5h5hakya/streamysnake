import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'data/tetrinimo.dart';
import 'main.dart';
import 'tetromino/i_block.dart';
import 'tetromino/j_block.dart';
import 'tetromino/l_block.dart';
import 'tetromino/o_block.dart';
import 'tetromino/s_block.dart';
import 'tetromino/t_block.dart';
import 'tetromino/z_block.dart';

class Player extends StatelessWidget {
  final VoidCallback? onBottomReached;
  Player({
    Key? key,
    this.onBottomReached,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _engine = TetrisController.of(context);
    return Center(
      child: StreamBuilder<Tetrimino>(
        stream: _engine.playerStream,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ClipRect(
              child: CustomPaint(
                painter:
                    _getNextPiece(snapshot.data!, _engine.extent.toDouble()),
                child: SizedBox(
                  width: _engine.effectiveWidth.toDouble(),
                  height: _engine.effectiveHeight.toDouble(),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }

  CustomPainter? _getNextPiece(Tetrimino nextPiece, double extent) {
    if (nextPiece.current == Piece.I)
      return IBlock(
        width: extent,
        angle: nextPiece.angle,
        yOffset: nextPiece.yOffset,
        origin: nextPiece.origin,
      );
    if (nextPiece.current == Piece.J)
      return JBlock(
        width: extent,
        angle: nextPiece.angle,
        yOffset: nextPiece.yOffset,
        origin: nextPiece.origin,
      );
    if (nextPiece.current == Piece.T)
      return TBlock(
        width: extent,
        angle: nextPiece.angle,
        yOffset: nextPiece.yOffset,
        origin: nextPiece.origin,
      );
    if (nextPiece.current == Piece.S)
      return SBlock(
        width: extent,
        angle: nextPiece.angle,
        yOffset: nextPiece.yOffset,
        origin: nextPiece.origin,
      );
    if (nextPiece.current == Piece.Z)
      return ZBlock(
        width: extent,
        angle: nextPiece.angle,
        yOffset: nextPiece.yOffset,
        origin: nextPiece.origin,
      );
    if (nextPiece.current == Piece.O)
      return OBlock(
        width: extent,
        yOffset: nextPiece.yOffset,
        origin: nextPiece.origin,
      );
    if (nextPiece.current == Piece.L)
      return LBlock(
        width: extent,
        angle: nextPiece.angle,
        yOffset: nextPiece.yOffset,
        origin: nextPiece.origin,
      );
    return null;
  }
}
