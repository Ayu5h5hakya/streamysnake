// Copyright (c) 2022 Razeware LLC
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the 'Software'), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended, or marketed for pedagogical
// or instructional purposes related to programming, coding, application
// development, or information technology.  Permission for such use, copying,
// modification, merger, publication, distribution, sublicensing, creation
// of derivative works, or sale is expressly withheld.
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import 'package:flutter/material.dart';

import 'data/game.dart';
import 'tetris.dart';

class UserInteractionLayer extends StatelessWidget {
  final Function(int)? onClick;
  final VoidCallback? onDoubleClick;
  const UserInteractionLayer({Key? key, this.onClick, this.onDoubleClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _engine = TetrisController.of(context);
    return StreamBuilder<GameData>(
        stream: _engine.gridStateStream,
        builder: (_, data) {
          if (data.data == null) return const SizedBox.shrink();

          if (data.data!.state == GameState.End)
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'TETRIS',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  FloatingActionButton(
                      child: const Icon(Icons.play_arrow),
                      onPressed: () {
                        _engine.resetGame();
                      }),
                  const Text(
                    '-REPLAY?-',
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
            );

          return IgnorePointer(
            ignoring: data.data!.state == GameState.Start,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      color: Colors.transparent,
                    ),
                    onTap: () {
                      if (onClick != null) onClick!(0);
                    },
                    onDoubleTap: () {
                      if (onDoubleClick != null) onDoubleClick!();
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      color: Colors.transparent,
                    ),
                    onTap: () {
                      if (onClick != null) onClick!(1);
                    },
                    onDoubleTap: () {
                      if (onDoubleClick != null) onDoubleClick!();
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}
