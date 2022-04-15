import 'dart:math';

import 'package:flutter/material.dart';

import 'tetromino/i_block.dart';

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
    return Stack(
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 30,
          ),
          itemBuilder: (_, index) => DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
            ),
          ),
          itemCount: 364,
        ),
        CustomPaint(
          child: Container(),
          painter: const IBlock(origin: Point(0, 0)),
        ),
      ],
    );
  }
}
