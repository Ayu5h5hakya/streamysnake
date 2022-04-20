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

List<int> mapToGridIndex(Tetrimino piece, double extent, int colCount) {
  final _horizontalNormal = piece.origin.x ~/ extent;
  final _verticalNormal = piece.origin.y ~/ extent;
  final _startIndex = colCount * _verticalNormal + _horizontalNormal;
  switch (piece.current) {
    case Piece.I:
      return _mapIBlock(_startIndex, colCount, piece.angle);
    case Piece.J:
      return _mapJBlock(_startIndex, colCount, piece.angle);
    case Piece.L:
      return _mapLBlock(_startIndex, colCount, piece.angle);
    case Piece.O:
      return _mapOBlock(_startIndex, colCount, piece.angle);
    case Piece.S:
      return _mapSBlock(_startIndex, colCount, piece.angle);
    case Piece.T:
      return _mapTBlock(_startIndex, colCount, piece.angle);
    case Piece.Z:
      return _mapZBlock(_startIndex, colCount, piece.angle);
  }
}

List<int> _mapIBlock(int startIndex, int colCount, double angle) {
  if (angle == 90 || angle == 270) {
    return [
      startIndex,
      startIndex + colCount + 1,
      startIndex + colCount + 2,
      startIndex + colCount + 3
    ];
  } else {
    return [startIndex, startIndex + 1, startIndex + 2, startIndex + 3];
  }
}

List<int> _mapJBlock(int startIndex, int colCount, double angle) {
  return [];
}

List<int> _mapLBlock(int startIndex, int colCount, double angle) {
  return [];
}

List<int> _mapOBlock(int startIndex, int colCount, double angle) {
  return [
    startIndex,
    startIndex + 1,
    startIndex + colCount + 1,
    startIndex + colCount + 2
  ];
}

List<int> _mapSBlock(int startIndex, int colCount, double angle) {
  return [];
}

List<int> _mapTBlock(int startIndex, int colCount, double angle) {
  return [];
}

List<int> _mapZBlock(int startIndex, int colCount, double angle) {
  return [];
}
