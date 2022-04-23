import 'package:flutter/material.dart';
import 'main.dart';

class TetrisBoard extends StatelessWidget {
  const TetrisBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _engine = TetrisController.of(context);
    return SizedBox(
      width: _engine.effectiveWidth.toDouble(),
      height: _engine.effectiveHeight.toDouble(),
      child: StreamBuilder<List<int>>(
        stream: _engine.gridStateStream,
        builder: (_, data) {
          return GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: _engine.extent.toDouble(),
            ),
            itemBuilder: (_, index) => DecoratedBox(
              decoration: BoxDecoration(
                color: (data.data?.contains(index) ?? false)
                    ? Colors.teal
                    : Colors.white,
              ),
            ),
            itemCount: _engine.getGridItemCount(),
          );
        },
      ),
    );
  }
}
