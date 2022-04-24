import 'dart:async';
import 'dart:math';

import 'package:rxdart/rxdart.dart';

import 'data/tetrinimo.dart';
import 'data/utils.dart';

class Engine {
  static const int COL_COUNT = 20;
  final double boardWidth, boardHeight;
  int extent = 0, effectiveWidth = 0, effectiveHeight = 0;
  final List<TetrisUnit> _setPieces = [];

  final StreamController<Tetrimino> _playerController = StreamController();
  final StreamController<List<TetrisUnit>> _gridController = StreamController();

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
        return RangeStream(0, ((effectiveHeight ~/ extent) - 0))
            .interval(const Duration(milliseconds: 100))
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
        ).takeWhile((_piece) {
          final _nextIndexes = mapToGridIndex(_piece, extent, COL_COUNT);
          return !_setPieces.any((item) => _nextIndexes.contains(item.index));
        }).doOnData((piece) {
          _current = piece;
        }).doOnDone(() {
          _setPieces.addAll(mapToGridIndex(
                  _current, extent, boardWidth ~/ extent)
              .map((item) => TetrisUnit(index: item, color: _current.color!)));
          _gridController.add(_setPieces);
          spawn();
        });
      });

  Stream<List<TetrisUnit>> get gridStateStream => _gridController.stream;

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

    _playerController.add(Tetrimino(
      current: _availablePieces[5],
      origin: Point<double>(0, 0),
      // origin:
      //     Point<double>(Random().nextInt(COL_COUNT - 4).toDouble() * extent,
      // 0),
    ));
  }
}
