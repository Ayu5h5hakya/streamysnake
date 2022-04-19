import 'dart:async';
import 'dart:math';

import 'package:rxdart/rxdart.dart';

import 'data/tetrinimo.dart';

class Engine {
  final double width, height, extent;
  StreamController<Tetrimino> _gameController = StreamController();
  StreamController<Tetrimino> _playerController = StreamController();

  Engine({required this.width, required this.height, required this.extent}) {
    _gameController = StreamController();
    _playerController = StreamController();

    _gameController.stream.listen((tetramino) {
      RangeStream(0, height ~/ extent)
          .interval(const Duration(seconds: 1))
          .listen((offset) {
        _playerController.add(
          Tetrimino(
              current: tetramino.current,
              origin: Point(tetramino.origin.x, tetramino.origin.y),
              position: offset * extent),
        );
      });
    });
  }
  Stream<Tetrimino> get playerStream => _playerController.stream;

  void spawn() {
    _gameController.add(Tetrimino(current: Piece.J, origin: const Point(0, 0)));
  }
}
