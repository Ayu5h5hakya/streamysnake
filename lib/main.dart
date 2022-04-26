import 'dart:math';

import 'package:flutter/material.dart';

import 'board.dart';
import 'data/game.dart';
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
          return Scaffold(
            backgroundColor: Colors.black54,
            body: TetrisController(
              engine: Engine(
                boardWidth: _width,
                boardHeight: _height,
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
    return Stack(
      children: [
        const Center(child: TetrisBoard()),
        Player(),
        _UserInteractionLayer(
          onClick: (side) {
            _engine.movePiece(side);
          },
          onDoubleClick: () {
            _engine.rotatePiece();
          },
        )
      ],
    );
  }
}

class _UserInteractionLayer extends StatelessWidget {
  final Function(int)? onClick;
  final VoidCallback? onDoubleClick;
  const _UserInteractionLayer({Key? key, this.onClick, this.onDoubleClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _engine = TetrisController.of(context);
    return StreamBuilder<GameData>(
        stream: _engine.gridStateStream,
        builder: (_, data) {
          if (data.data == null) return const SizedBox.shrink();
          return IgnorePointer(
            ignoring: data.data!.state == GameState.Start,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      color: Colors.transparent,
                    ),
                    onTap: () {
                      if (onClick != null) onClick!(0);
                    },
                    onDoubleTap: () {
                      if (onDoubleClick != null) onDoubleClick!();
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      color: Colors.transparent,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(onPressed: () {}),
                      ),
                    ),
                    onTap: () {
                      if (onClick != null) onClick!(1);
                    },
                    onDoubleTap: () {
                      if (onDoubleClick != null) onDoubleClick!();
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}
