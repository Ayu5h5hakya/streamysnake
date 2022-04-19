import 'dart:math';

enum Piece { I, L, J, S, T, Z, O }

class Tetrimino {
  final Piece current;
  final Point<double> origin;
  final double angle, position;

  Tetrimino(
      {required this.current,
      required this.origin,
      this.angle = 0,
      this.position = 0});
}
