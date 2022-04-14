import 'package:flutter/material.dart';

import 'tetromino/j_block.dart';
import 'tetromino/l_block.dart';

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
    return CustomPaint(
      painter: LBlock(),
      child: Container(),
    );
  }
}
