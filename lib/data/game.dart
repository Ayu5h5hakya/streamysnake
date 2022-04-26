import 'tetrinimo.dart';

enum GameState { Start, Play, End }

class GameData {
  final GameState state;
  final List<TetrisUnit> pieces;
  GameData({required this.state, required this.pieces});
}
