import 'package:flutter/material.dart';
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
      child: StreamBuilder<List<TetrisUnit>>(
        stream: _engine.gridStateStream,
        builder: (_, data) {
          return GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: _engine.extent.toDouble(),
            ),
            itemBuilder: (_, index) {
              var _color = Colors.white;
              if (data.data != null) {
                for (final unit in data.data!) {
                  if (unit.index == index) {
                    _color = unit.color;
                    break;
                  }
                }
              }
              return ColoredBox(
                color: _color,
              );
            },
            itemCount: _engine.getGridItemCount(),
          );
        },
      ),
    );
  }
}
