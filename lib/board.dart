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
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(),
        right: BorderSide(),
        bottom: BorderSide(),
        top: BorderSide(),
      )),
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
              return DecoratedBox(
                decoration: UnitDecoration(),
              );
            },
            itemCount: _engine.getGridItemCount(),
          );
        },
      ),
    );
  }
}
