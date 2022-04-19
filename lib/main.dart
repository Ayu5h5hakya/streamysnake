import 'dart:math';

import 'package:flutter/material.dart';

import 'board.dart';
import 'engine.dart';
import 'player.dart';

void main() {
  runApp(const Game());
}

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Builder(builder: (ctx) {
          final _width = MediaQuery.of(ctx).size.width * 0.7;
          final _height = MediaQuery.of(ctx).size.height * 0.75;
          final _maxExtent = sqrt(_width * _height / 640);
          return Scaffold(
            body: TetrisController(
              engine: Engine(
                width: _width,
                height: _height,
                extent: _maxExtent,
              ),
              child: const Tetris(),
            ),
          );
        }),
      );
}

class TetrisController extends InheritedWidget {
  final Engine engine;
  const TetrisController({
    Key? key,
    required this.engine,
    required Widget child,
  }) : super(key: key, child: child);

  static Engine of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<TetrisController>();
    assert(result != null, 'No Engine found in context');
    return result!.engine;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

class Tetris extends StatelessWidget {
  const Tetris({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _engine = TetrisController.of(context);
    return GestureDetector(
      child: Stack(
        children: [
          Center(child: TetrisBoard()),
          Player(),
        ],
      ),
      onTap: () {
        _engine.spawn();
      },
    );
  }
}
