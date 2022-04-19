import 'package:flutter/widgets.dart';

import 'data/tetrinimo.dart';
import 'main.dart';
import 'tetromino/i_block.dart';

class Player extends StatelessWidget {
  final VoidCallback? onBottomReached;
  Player({
    Key? key,
    this.onBottomReached,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _engine = TetrisController.of(context);
    return Center(
      child: SizedBox(
        width: _engine.width,
        height: _engine.height,
        child: StreamBuilder<Tetrimino>(
          stream: _engine.playerStream,
          builder: ((context, snapshot) {
            if (snapshot.hasData)
              return CustomPaint(
                painter: IBlock(
                  width: _engine.extent,
                  angle: snapshot.data!.angle,
                  position: snapshot.data!.position,
                  origin: snapshot.data!.origin,
                ),
              );
            return const SizedBox.shrink();
          }),
        ),
      ),
    );
  }
}
