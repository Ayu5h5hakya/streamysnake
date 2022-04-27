import 'tetrinimo.dart';

int getMaxExtentByPiece(Tetrimino tetrimino) {
  switch (tetrimino.current) {
    case Piece.I:
    case Piece.J:
    case Piece.L:
    case Piece.S:
    case Piece.T:
    case Piece.Z:
      return _getBlockExtent(tetrimino.angle) - 1;
    case Piece.O:
      return 1;
  }
}

int _getBlockExtent(double angle) {
  if (angle == 90 || angle == 270) return 4;
  return 2;
}

List<int> mapToGridIndex(Tetrimino piece, int extent, int colCount) {
  final _horizontalNormal = (piece.xOffset * extent + piece.origin.x) ~/ extent;
  final _startIndex = colCount * piece.yOffset.toInt() + _horizontalNormal;
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
      startIndex + 2,
      startIndex + colCount + 2,
      startIndex + 2 * colCount + 2,
      startIndex + 3 * colCount + 2
    ];
  } else {
    return [startIndex, startIndex + 1, startIndex + 2, startIndex + 3];
  }
}

List<int> _mapJBlock(int startIndex, int colCount, double angle) {
  if (angle == 90)
    return [
      startIndex + 1,
      startIndex + 2,
      startIndex + colCount + 1,
      startIndex + 2 * colCount + 1
    ];
  if (angle == 180)
    return [
      startIndex + colCount,
      startIndex + colCount + 1,
      startIndex + colCount + 2,
      startIndex + 2 * colCount + 2
    ];
  if (angle == 270)
    return [
      startIndex + 1,
      startIndex + colCount + 1,
      startIndex + 2 * colCount + 1,
      startIndex + 2 * colCount,
    ];
  return [
    startIndex,
    startIndex + colCount,
    startIndex + colCount + 1,
    startIndex + colCount + 2,
  ];
}

List<int> _mapLBlock(int startIndex, int colCount, double angle) {
  if (angle == 90)
    return [
      startIndex + 2,
      startIndex + 3,
      startIndex + colCount + 1,
      startIndex + 2 * colCount + 1
    ];
  if (angle == 180)
    return [
      startIndex + colCount,
      startIndex + colCount + 1,
      startIndex + colCount + 2,
      startIndex + 2 * colCount + 2
    ];
  if (angle == 270)
    return [
      startIndex + 1,
      startIndex + colCount + 1,
      startIndex + 2 * colCount + 1,
      startIndex + 2 * colCount,
    ];
  return [
    startIndex,
    startIndex + colCount,
    startIndex + colCount + 1,
    startIndex + colCount + 2,
  ];
}

List<int> _mapOBlock(int startIndex, int colCount, double angle) {
  return [
    startIndex,
    startIndex + 1,
    startIndex + colCount + 1,
    startIndex + colCount
  ];
}

List<int> _mapSBlock(int startIndex, int colCount, double angle) {
  if (angle == 90)
    return [
      startIndex + 2,
      startIndex + 3,
      startIndex + colCount + 1,
      startIndex + 2 * colCount + 1
    ];
  if (angle == 180)
    return [
      startIndex + colCount,
      startIndex + colCount + 1,
      startIndex + colCount + 2,
      startIndex + 2 * colCount + 2
    ];
  if (angle == 270)
    return [
      startIndex + 1,
      startIndex + colCount + 1,
      startIndex + 2 * colCount + 1,
      startIndex + 2 * colCount,
    ];
  return [
    startIndex + 1,
    startIndex + 2,
    startIndex + colCount,
    startIndex + colCount + 1,
  ];
}

List<int> _mapTBlock(int startIndex, int colCount, double angle) {
  if (angle == 90)
    return [
      startIndex + 1,
      startIndex + colCount + 1,
      startIndex + colCount + 2,
      startIndex + 2 * colCount + 1
    ];
  if (angle == 180)
    return [
      startIndex + colCount,
      startIndex + colCount + 1,
      startIndex + colCount + 2,
      startIndex + 2 * colCount + 1
    ];
  if (angle == 270)
    return [
      startIndex + 1,
      startIndex + colCount + 1,
      startIndex + colCount,
      startIndex + 2 * colCount + 1,
    ];
  return [
    startIndex + 1,
    startIndex + colCount,
    startIndex + colCount + 1,
    startIndex + colCount + 2,
  ];
}

List<int> _mapZBlock(int startIndex, int colCount, double angle) {
  if (angle == 90)
    return [
      startIndex + 2,
      startIndex + 3,
      startIndex + colCount + 1,
      startIndex + 2 * colCount + 1
    ];
  if (angle == 180)
    return [
      startIndex + colCount,
      startIndex + colCount + 1,
      startIndex + colCount + 2,
      startIndex + 2 * colCount + 2
    ];
  if (angle == 270)
    return [
      startIndex + 1,
      startIndex + colCount + 1,
      startIndex + 2 * colCount + 1,
      startIndex + 2 * colCount,
    ];
  return [
    startIndex,
    startIndex + 1,
    startIndex + colCount + 1,
    startIndex + colCount + 2,
  ];
}
