class UserInput {
  final int angle;
  final int xOffset;
  final int yOffset;

  UserInput({
    required this.angle,
    required this.xOffset,
    required this.yOffset,
  });

  @override
  String toString() {
    return 'UserInput(angle: $angle, xOffset: $xOffset, yOffset:  $yOffset)';
  }
}
