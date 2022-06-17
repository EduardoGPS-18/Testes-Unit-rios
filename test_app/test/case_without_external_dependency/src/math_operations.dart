class MathOperations {
  static double binarySum({
    required double firstNumber,
    required double secondaryNumber,
  }) {
    return firstNumber + secondaryNumber;
  }

  static double division({
    required double divider,
    required double dividend,
  }) {
    if (divider == 0) {
      throw ImpossibleOperationException();
    }
    return dividend / divider;
  }
}

class ImpossibleOperationException implements Exception {}
