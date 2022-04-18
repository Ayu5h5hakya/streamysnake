import 'dart:math';

import 'package:flutter/material.dart';

import 'board.dart';
import 'player.dart';

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
      home: Scaffold(
        body: Tetris(),
      ),
    );
  }
}

class Tetris extends StatelessWidget {
  const Tetris({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width * 0.7;
    final _height = MediaQuery.of(context).size.height * 0.75;
    final _maxExtent = sqrt(_width * _height / 640);

    return Stack(
      children: [
        Center(
            child: TetrisBoard(
          extent: _maxExtent,
        )),
        Player(
          boardWidth: _width,
          boardHeight: _height,
          extent: _maxExtent,
        ),
      ],
    );
  }
}
