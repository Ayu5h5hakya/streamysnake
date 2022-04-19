import 'dart:async';
import 'dart:math';

import 'package:rxdart/rxdart.dart';

import 'data/tetrinimo.dart';

class Engine {
  final double width, height, extent;
  final StreamController<Tetrimino> _playerController = StreamController();
  final StreamController<List<int>> _gridController = StreamController();

  Engine({required this.width, required this.height, required this.extent});

  Stream<Tetrimino> get playerStream => _playerController.stream.flatMap(
        (tetramino) => RangeStream(0, height ~/ extent)
            .interval(const Duration(seconds: 1))
            .map(
              (offset) => Tetrimino(
                current: tetramino.current,
                origin: Point(tetramino.origin.x, tetramino.origin.y),
                position: offset * extent,
              ),
            )
            .doOnDone(() {
          spawn();
        }),
      );

  Stream<List<int>> get gridStateStream => _gridController.stream;

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
      current: _availablePieces[Random().nextInt(7)],
      origin: _possiblePositions[Random().nextInt(4)] * extent,
    ));
  }
}
