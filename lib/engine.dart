// Copyright (c) 2022 Razeware LLC
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the 'Software'), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended, or marketed for pedagogical
// or instructional purposes related to programming, coding, application
// development, or information technology.  Permission for such use, copying,
// modification, merger, publication, distribution, sublicensing, creation
// of derivative works, or sale is expressly withheld.
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
  int extent = 0, effectiveWidth = 0, effectiveHeight = 0;
  final List<Color> _setPieces = [];

  int _itemCount = 0;
  int getGridItemCount() => _itemCount;

  final StreamController<Tetrimino> _playerController = BehaviorSubject();
  final StreamController<UserInput> _inputController = BehaviorSubject();
  final StreamController<GameData> _gameController =
      BehaviorSubject.seeded(GameData(state: GameState.Start, pieces: []));

  Engine({required this.boardWidth, required this.boardHeight}) {
    effectiveWidth = (boardWidth / COL_COUNT).floor() * COL_COUNT;
    extent = effectiveWidth ~/ COL_COUNT;
    effectiveHeight = (boardHeight / extent).floor() * extent;
    _itemCount = COL_COUNT * (effectiveHeight ~/ extent);
    _setPieces.addAll(List.filled(_itemCount, Colors.white));
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
                !_nextIndexes.any((item) => _setPieces[item] != Colors.white);
            return _isPieceInsideTheBoard && _isNextPositionCollisionFree;
          }).doOnData((_validTransformedPiece) {
            _current = _validTransformedPiece;
          }).doOnDone(() {
            final _indexes = mapToGridIndex(_current, extent, COL_COUNT);
            _setPieces[_indexes[0]] = _current.color!;
            _setPieces[_indexes[1]] = _current.color!;
            _setPieces[_indexes[2]] = _current.color!;
            _setPieces[_indexes[3]] = _current.color!;

            if (isSetPieceAtTheTop(_setPieces, COL_COUNT)) {
              _gameController.add(GameData(state: GameState.End, pieces: []));
              _playerController.add(
                  Tetrimino(current: Piece.Empty, origin: const Point(0, 0)));
            } else {
              _gameController
                  .add(GameData(state: GameState.Play, pieces: _setPieces));
              _spawn();
            }
          });
        },
      );

  Stream<GameData> get gridStateStream {
    return _gameController.stream.flatMap((data) {
      if (data.state == GameState.End)
        return TimerStream(data, const Duration(seconds: 2));

      final _filledGridPieces = getFilledRowIndexes(_setPieces, COL_COUNT);
      if (_filledGridPieces.isEmpty) return _gameController.stream;
      return Stream.fromIterable(_filledGridPieces).map((index) {
        _setPieces.removeRange(index, index + COL_COUNT);
        _setPieces.insertAll(
            0, List.generate(COL_COUNT, (index) => Colors.white));
        return GameData(state: data.state, pieces: _setPieces);
      });
    });
  }

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
      current: _availablePieces[Random().nextInt(_availablePieces.length)],
      angle: 90,
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

  void resetGame() {
    _setPieces.clear();
    _setPieces.addAll(List.filled(_itemCount, Colors.white));
    spawn();
  }
}
