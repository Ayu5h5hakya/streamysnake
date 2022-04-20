import 'dart:async';
import 'dart:math';

import 'package:rxdart/rxdart.dart';

import 'data/tetrinimo.dart';
import 'data/utils.dart';

class Engine {
  final double width, height, extent;
  final List<Tetrimino> _setPieces = [];
  final StreamController<Tetrimino> _playerController = StreamController();
  final StreamController<List<Tetrimino>> _gridController = StreamController();

  Engine({required this.width, required this.height, required this.extent});

  Stream<Tetrimino> get playerStream =>
      _playerController.stream.flatMap((tetramino) {
        var _current = tetramino;
        return RangeStream(0, height ~/ extent - getMaxExtentByPiece(tetramino))
            .interval(const Duration(milliseconds: 500))
            .map(
              (offset) => Tetrimino(
                current: tetramino.current,
                origin: Point(tetramino.origin.x, tetramino.origin.y),
                position: offset * extent,
              ),
            )
            .doOnData((piece) {
          _current = piece;
        }).doOnDone(() {
          _setPieces.add(_current);
          _gridController.add(_setPieces);
          spawn();
        });
      });

  Stream<List<Tetrimino>> get gridStateStream => _gridController.stream;

  void spawn() {
    final _availablePieces = [
      Piece.I,
      Piece.J,
      Piece.T,
      Piece.S,
      Piece.Z,
      Piece.O,
      Piece.L,
    ];

    final _possiblePositions = [
      const Point<double>(0, 0),
      const Point<double>(4, 0),
      const Point<double>(8, 0),
      const Point<double>(12, 0),
    ];
    _playerController.add(Tetrimino(
      current: _availablePieces[Random().nextInt(_availablePieces.length)],
      origin: _possiblePositions[Random().nextInt(_possiblePositions.length)],
    ));
  }
}
