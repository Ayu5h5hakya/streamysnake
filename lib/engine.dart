import 'dart:async';
import 'dart:math';

import 'package:rxdart/rxdart.dart';

import 'data/tetrinimo.dart';
import 'data/utils.dart';

class Engine {
  static const int COL_COUNT = 20;
  final double boardWidth, boardHeight;
  int extent = 0, effectiveWidth = 0, effectiveHeight = 0;
  final List<Tetrimino> _setPieces = [];
  final StreamController<Tetrimino> _playerController = StreamController();
  final StreamController<List<Tetrimino>> _gridController = StreamController();

  Engine({required this.boardWidth, required this.boardHeight}) {
    effectiveWidth = (boardWidth / COL_COUNT).floor() * COL_COUNT;
    extent = effectiveWidth ~/ COL_COUNT;
    effectiveHeight = (boardHeight / extent).floor() * extent;
  }

  int getGridItemCount() {
    return COL_COUNT * (effectiveHeight ~/ extent);
  }

  Stream<Tetrimino> get playerStream =>
      _playerController.stream.flatMap((tetramino) {
        var _current = tetramino;
        print(effectiveHeight ~/ extent);
        print(getMaxExtentByPiece(_current));
        return RangeStream(0,
                ((effectiveHeight ~/ extent) - getMaxExtentByPiece(_current)))
            .interval(const Duration(milliseconds: 500))
            .map(
          (offset) {
            print(offset);
            return Tetrimino(
              angle: tetramino.angle,
              current: tetramino.current,
              origin: Point(tetramino.origin.x, tetramino.origin.y),
              position: offset.toDouble(),
            );
          },
        ).doOnData((piece) {
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
          _setIndexes
              .addAll(mapToGridIndex(piece, extent, boardWidth ~/ extent));
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
      Point<double>(4.0 * extent, 0),
      Point<double>(8.0 * extent, 0),
      Point<double>(12.0 * extent, 0),
      Point<double>(16.0 * extent, 0),
    ];
    _playerController.add(Tetrimino(
      current: _availablePieces[Random().nextInt(_availablePieces.length)],
      origin: _possiblePositions[Random().nextInt(_possiblePositions.length)],
    ));
  }
}
