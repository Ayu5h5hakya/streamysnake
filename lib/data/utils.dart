import 'tetrinimo.dart';

int getMaxExtentByPiece(Tetrimino tetrimino) {
  switch (tetrimino.current) {
    case Piece.I:
    case Piece.J:
    case Piece.L:
    case Piece.S:
    case Piece.T:
    case Piece.Z:
      return _getBlockExtent(tetrimino.angle);
    case Piece.O:
      return 2;
  }
}

int _getBlockExtent(double angle) {
  if (angle == 90 || angle == 270) return 4;
  return 0;
}

List<int> mapToGridIndex(Tetrimino piece, double extent) {
  final _horizontalNormal = piece.origin.x ~/ extent;
  final _verticalNormal = piece.origin.y ~/ extent;
  switch (piece.current) {
    case Piece.I:
      return _mapIBlock(_horizontalNormal, _verticalNormal, piece.angle);
    case Piece.J:
      return _mapJBlock(_horizontalNormal, _verticalNormal, piece.angle);
    case Piece.L:
      return _mapLBlock(_horizontalNormal, _verticalNormal, piece.angle);
    case Piece.O:
      return _mapOBlock(_horizontalNormal, _verticalNormal, piece.angle);
    case Piece.S:
      return _mapSBlock(_horizontalNormal, _verticalNormal, piece.angle);
    case Piece.T:
      return _mapTBlock(_horizontalNormal, _verticalNormal, piece.angle);
    case Piece.Z:
      return _mapZBlock(_horizontalNormal, _verticalNormal, piece.angle);
  }
}

List<int> _mapIBlock(int horIndex, int verIndex, double angle) {
  if (angle == 90 || angle == 270) {
    return [verIndex, verIndex + 10, verIndex + 20, verIndex + 30];
  } else {
    return [horIndex, horIndex + 1, horIndex + 2, horIndex + 3];
  }
}

List<int> _mapJBlock(int horIndex, int verIndex, double angle) {
  return [];
}

List<int> _mapLBlock(int horIndex, int verIndex, double angle) {
  return [];
}

List<int> _mapOBlock(int horIndex, int verIndex, double angle) {
  return [];
}

List<int> _mapSBlock(int horIndex, int verIndex, double angle) {
  return [];
}

List<int> _mapTBlock(int horIndex, int verIndex, double angle) {
  return [];
}

List<int> _mapZBlock(int horIndex, int verIndex, double angle) {
  return [];
}
