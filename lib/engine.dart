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
                position: offset.toDouble(),
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

  Stream<List<int>> get gridStateStream =>
      _gridController.stream.map((List<Tetrimino> setPieces) {
        final _setIndexes = <int>[];
        for (final piece in setPieces) {
          _setIndexes.addAll(mapToGridIndex(piece, extent, width ~/ extent));
        }
        return _setIndexes;
      });

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
      Point<double>(4 * extent, 0),
      Point<double>(8 * extent, 0),
      Point<double>(12 * extent, 0),
    ];
    _playerController.add(Tetrimino(
      current: Piece.T,
      origin: _possiblePositions[Random().nextInt(_possiblePositions.length)],
    ));
  }
}
