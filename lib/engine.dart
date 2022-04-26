import 'dart:async';
import 'dart:math';

import 'package:rxdart/rxdart.dart';

import 'data/game.dart';
import 'data/tetrinimo.dart';
import 'data/utils.dart';

class Engine {
  static const int COL_COUNT = 20;
  final double boardWidth, boardHeight;
  int extent = 0, effectiveWidth = 0, effectiveHeight = 0, _itemCount = 0;
  final List<TetrisUnit> _setPieces = [];

  final StreamController<Tetrimino> _playerController = StreamController();
  final StreamController<GameData> _gameController = BehaviorSubject();

  Engine({required this.boardWidth, required this.boardHeight}) {
    effectiveWidth = (boardWidth / COL_COUNT).floor() * COL_COUNT;
    extent = effectiveWidth ~/ COL_COUNT;
    effectiveHeight = (boardHeight / extent).floor() * extent;
    _gameController.add(GameData(state: GameState.Start, pieces: []));
  }

  int getGridItemCount() {
    _itemCount = COL_COUNT * (effectiveHeight ~/ extent);
    return _itemCount;
  }

  Stream<Tetrimino> get playerStream =>
      _playerController.stream.flatMap((tetramino) {
        var _current = tetramino;
        return RangeStream(0, ((effectiveHeight ~/ extent)))
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

          final _isPieceInsideTheBoard =
              !_nextIndexes.any((index) => index > _itemCount);
          final _isNextPositionCollisionFree =
              !_setPieces.any((item) => _nextIndexes.contains(item.index));
          return _isPieceInsideTheBoard && _isNextPositionCollisionFree;
        }).doOnData((piece) {
          _current = piece;
        }).doOnDone(() {
          _setPieces.addAll(mapToGridIndex(
                  _current, extent, boardWidth ~/ extent)
              .map((item) => TetrisUnit(index: item, color: _current.color!)));
          _gameController
              .add(GameData(state: GameState.Play, pieces: _setPieces));
          _spawn();
        });
      });

  Stream<GameData> get gridStateStream => _gameController.stream;

  void _spawn() {
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
      current: _availablePieces[Random().nextInt(_availablePieces.length)],
      origin:
          Point<double>(Random().nextInt(COL_COUNT - 4).toDouble() * extent, 0),
    ));
  }

  void spawn() {
    _gameController.add(GameData(state: GameState.Play, pieces: []));
    _spawn();
  }

  void movePiece(int direction) {
    print(direction == 0 ? 'left' : 'right');
  }

  void rotatePiece() {
    print('rotate');
  }
}
