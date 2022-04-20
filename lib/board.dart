import 'package:flutter/material.dart';
import 'data/tetrinimo.dart';
import 'main.dart';

class TetrisBoard extends StatelessWidget {
  const TetrisBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _engine = TetrisController.of(context);
    return FractionallySizedBox(
      widthFactor: 0.7,
      heightFactor: 0.75,
      child: StreamBuilder<List<Tetrimino>>(
        stream: _engine.gridStateStream,
        builder: (_, data) {
          print(data);
          return GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: _engine.extent,
            ),
            itemBuilder: (_, index) => DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
              ),
            ),
            itemCount: 648,
          );
        },
      ),
    );
  }
}
