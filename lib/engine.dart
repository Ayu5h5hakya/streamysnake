import 'dart:async';

import 'package:rxdart/rxdart.dart';

class Engine {
  final List<bool> _gridState = List<bool>.filled(648, false);
  final List<int> _barrier = List.filled(19, -1);

  final StreamController _gameController = StreamController<int>();

  start() => _gameController.stream;
}
