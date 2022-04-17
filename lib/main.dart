import 'dart:math';

import 'package:flutter/material.dart';

import 'constants.dart';
import 'tetromino/i_block.dart';
import 'tetromino/j_block.dart';
import 'tetromino/l_block.dart';
import 'tetromino/o_block.dart';
import 'tetromino/s_block.dart';
import 'tetromino/t_block.dart';
import 'tetromino/z_block.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: TetrisBoard(),
      ),
    );
  }
}

class TetrisBoard extends StatelessWidget {
  const TetrisBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width * 0.7;
    final _height = MediaQuery.of(context).size.height * 0.75;
    final _maxExtent = sqrt(_width * _height / 640);
    return Stack(
      children: [
        Center(
          child: FractionallySizedBox(
            widthFactor: 0.7,
            heightFactor: 0.75,
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: _maxExtent,
              ),
              itemBuilder: (_, index) => DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                ),
              ),
              itemCount: 648,
            ),
          ),
        ),
        // Center(
        //   child: SizedBox(
        //     width: _width,
        //     height: _height,
        //     child: CustomPaint(
        //       painter: IBlock(
        //         angle: 90,
        //         width: _maxExtent,
        //         origin: const Point(210, 210),
        //       ),
        //     ),
        //   ),
        // ),
        // Center(
        //   child: SizedBox(
        //     width: _width,
        //     height: _height,
        //     child: CustomPaint(
        //       painter: JBlock(
        //         width: _maxExtent,
        //         origin: const Point(30, 30),
        //       ),
        //     ),
        //   ),
        // ),
        // Center(
        //   child: SizedBox(
        //     width: _width,
        //     height: _height,
        //     child: CustomPaint(
        //       painter: LBlock(
        //         width: _maxExtent,
        //         origin: const Point(60, 60),
        //       ),
        //     ),
        //   ),
        // ),
        // Center(
        //   child: SizedBox(
        //     width: _width,
        //     height: _height,
        //     child: CustomPaint(
        //       painter: OBlock(
        //         width: _maxExtent,
        //         origin: const Point(120, 120),
        //       ),
        //     ),
        //   ),
        // ),
        Center(
          child: SizedBox(
            width: _width,
            height: _height,
            child: CustomPaint(
              painter: SBlock(
                width: _maxExtent,
                origin: const Point(150, 180),
              ),
            ),
          ),
        ),
        // Center(
        //   child: SizedBox(
        //     width: _width,
        //     height: _height,
        //     child: CustomPaint(
        //       painter: TBlock(
        //         width: _maxExtent,
        //         origin: const Point(90, 180),
        //       ),
        //     ),
        //   ),
        // ),
        // Center(
        //   child: SizedBox(
        //     width: _width,
        //     height: _height,
        //     child: CustomPaint(
        //       painter: ZBlock(
        //         width: _maxExtent,
        //         origin: const Point(90, 270),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
