import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'data/game.dart';
import 'data/input.dart';
import 'data/tetrinimo.dart';
import 'data/utils.dart';

class Engine {
  static const int COL_COUNT = 20;
  final double boardWidth, boardHeight;
  int extent = 0, effectiveWidth = 0, effectiveHeight = 0, _itemCount = 0;
  final List<TetrisUnit> _setPieces = [];

  final StreamController<Tetrimino> _playerController = BehaviorSubject();
  final StreamController<UserInput> _inputController = BehaviorSubject();
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

  Stream<Tetrimino> get playerStream => _playerController.stream.switchMap(
        (base) {
          var _current = base;
          return CombineLatestStream.combine2<UserInput, int, Tetrimino>(
            _inputController.stream
                .startWith(UserInput(angle: 0, xOffset: 0, yOffset: 0))
                .map((input) => UserInput(
                    angle: _current.angle.toInt() + input.angle,
                    xOffset: _current.xOffset.toInt() + input.xOffset,
                    yOffset: _current.yOffset.toInt() + input.yOffset)),
            _playerController.stream.switchMap((value) =>
                RangeStream(0, effectiveHeight ~/ extent)
                    .interval(const Duration(milliseconds: 500))),
            (userInput, yOffset) => Tetrimino(
              angle: (userInput.angle).toDouble(),
              current: _current.current,
              origin: Point(_current.origin.x, _current.origin.y),
              yOffset: yOffset.toDouble(),
              xOffset: (userInput.xOffset).toDouble(),
            ),
          ).takeWhile((_transformedPiece) {
            final _nextIndexes =
                mapToGridIndex(_transformedPiece, extent, COL_COUNT);
            final _isPieceInsideTheBoard =
                !_nextIndexes.any((index) => index > _itemCount);
            final _isNextPositionCollisionFree =
                !_setPieces.any((item) => _nextIndexes.contains(item.index));
            return _isPieceInsideTheBoard && _isNextPositionCollisionFree;
          }).doOnData((_validTransformedPiece) {
            _current = _validTransformedPiece;
          }).doOnDone(() {
            _setPieces.addAll(
                mapToGridIndex(_current, extent, boardWidth ~/ extent).map(
                    (item) => TetrisUnit(index: item, color: _current.color!)));
            _gameController
                .add(GameData(state: GameState.Play, pieces: _setPieces));
            _spawn();
          });
        },
      );

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

    _inputController.add(UserInput(angle: 0, xOffset: 0, yOffset: 0));
    _playerController.add(Tetrimino(
      current: _availablePieces[2],
      origin:
          Point<double>(Random().nextInt(COL_COUNT - 4).toDouble() * extent, 0),
    ));
  }

  void spawn() {
    _gameController.add(GameData(state: GameState.Play, pieces: []));
    _spawn();
  }

  void movePiece(int direction) {
    _inputController
        .add(UserInput(angle: 0, xOffset: direction == 0 ? -1 : 1, yOffset: 0));
  }

  void rotatePiece() {
    _inputController.add(UserInput(angle: 90, xOffset: 0, yOffset: 0));
  }
}
