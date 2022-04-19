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
      child: SizedBox(
        width: _engine.width,
        height: _engine.height,
        child: StreamBuilder<Tetrimino>(
          stream: _engine.playerStream,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return CustomPaint(
                painter: _getNextPiece(snapshot.data!, _engine.extent),
              );
            }
            return const SizedBox.shrink();
          }),
        ),
      ),
    );
  }

  CustomPainter? _getNextPiece(Tetrimino nextPiece, double extent) {
    if (nextPiece.current == Piece.I)
      return IBlock(
        width: extent,
        angle: nextPiece.angle,
        position: nextPiece.position,
        origin: nextPiece.origin,
      );
    if (nextPiece.current == Piece.J)
      return JBlock(
        width: extent,
        angle: nextPiece.angle,
        position: nextPiece.position,
        origin: nextPiece.origin,
      );
    if (nextPiece.current == Piece.T)
      return TBlock(
        width: extent,
        angle: nextPiece.angle,
        position: nextPiece.position,
        origin: nextPiece.origin,
      );
    if (nextPiece.current == Piece.S)
      return SBlock(
        width: extent,
        angle: nextPiece.angle,
        position: nextPiece.position,
        origin: nextPiece.origin,
      );
    if (nextPiece.current == Piece.Z)
      return ZBlock(
        width: extent,
        angle: nextPiece.angle,
        position: nextPiece.position,
        origin: nextPiece.origin,
      );
    if (nextPiece.current == Piece.O)
      return OBlock(
        width: extent,
        position: nextPiece.position,
        origin: nextPiece.origin,
      );
    if (nextPiece.current == Piece.L)
      return LBlock(
        width: extent,
        angle: nextPiece.angle,
        position: nextPiece.position,
        origin: nextPiece.origin,
      );
    return null;
  }
}
