import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'tetromino/i_block.dart';

class Player extends StatefulWidget {
  final double boardWidth, boardHeight, extent;
  Player(
      {Key? key,
      required this.boardWidth,
      required this.boardHeight,
      required this.extent})
      : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  int _position = 0;
  @override
  void initState() {
    RangeStream(0, 100).interval(const Duration(seconds: 1)).listen((event) {
      setState(() {
        _position = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.boardWidth,
        height: widget.boardHeight,
        child: CustomPaint(
          painter: IBlock(
            width: widget.extent,
            position: widget.extent * _position,
            origin: const Point(0, 0),
          ),
        ),
      ),
    );
  }
}
