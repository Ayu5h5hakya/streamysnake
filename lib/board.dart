import 'package:flutter/material.dart';
import 'data/game.dart';
import 'data/tetrinimo.dart';
import 'main.dart';
import 'unit_decoration.dart';

class TetrisBoard extends StatelessWidget {
  const TetrisBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _engine = TetrisController.of(context);
    return Container(
      color: Colors.white,
      width: _engine.effectiveWidth.toDouble(),
      height: _engine.effectiveHeight.toDouble(),
      child: StreamBuilder<GameData>(
        stream: _engine.gridStateStream,
        builder: (_, data) {
          if (data.hasData) {
            switch (data.data!.state) {
              case GameState.Start:
                return Center(
                  child: FloatingActionButton(onPressed: () {
                    _engine.spawn();
                  }),
                );
              case GameState.Play:
                return GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: _engine.extent.toDouble(),
                  ),
                  itemBuilder: (_, index) {
                    var _color = Colors.white;
                    if (data.data != null) {
                      for (final unit in data.data!.pieces) {
                        if (unit.index == index) {
                          print('found');
                          _color = unit.color;
                          break;
                        }
                      }
                    }
                    return ColoredBox(
                      color: _color,
                      child: Text(
                        index.toString(),
                        style: TextStyle(fontSize: 8.0),
                      ),
                    );
                  },
                  itemCount: _engine.getGridItemCount(),
                );
              case GameState.End:
                return Center(
                  child: FloatingActionButton(onPressed: () {
                    _engine.spawn();
                  }),
                );
            }
          } else
            return SizedBox();
        },
      ),
    );
  }
}
