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
    final _columns = _width / _maxExtent;
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
              itemCount: 640 + _columns.toInt(),
            ),
          ),
        ),
        Center(
            child: SizedBox(
          width: _width,
          height: _height,
          child: CustomPaint(
            painter: JBlock(width: _maxExtent, origin: const Point(0, 0)),
          ),
        )),
        // CustomPaint(
        //   child: Container(),
        //   painter: const JBlock(origin: Point(90, 90)),
        // ),
        // CustomPaint(
        //   child: Container(),
        //   painter: const LBlock(origin: Point(90, 90)),
        // ),
        // CustomPaint(
        //   child: Container(),
        //   painter: const OBlock(origin: Point(90, 90)),
        // ),
        // CustomPaint(
        //   child: Container(),
        //   painter: const SBlock(origin: Point(90, 90)),
        // ),
        // CustomPaint(
        //   child: Container(),
        //   painter: const TBlock(origin: Point(90, 90)),
        // ),
        // CustomPaint(
        //   child: Container(),
        //   painter: const ZBlock(origin: Point(120, 120)),
        // ),
      ],
    );
  }
}
