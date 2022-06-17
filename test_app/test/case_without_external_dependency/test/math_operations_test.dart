import '../src/math_operations.dart';

void expect<T>(T value, T expect) => print(value == expect ? 'Test passed' : 'Test failed');

void testSumOperationSuccess() {
  final value = MathOperations.binarySum(firstNumber: 5, secondaryNumber: 10);
  const expectValue = 15;
  expect(value, expectValue);
}

void testDivisionOperationSuccess() {
  final value = MathOperations.division(dividend: 5, divider: 2);
  const expectValue = 2.5;
  expect(value, expectValue);
}

void testDivisionOperationError() {
  try {
    MathOperations.division(dividend: 5, divider: 0);
  } on Exception catch (err) {
    expect(err.runtimeType, ImpossibleOperationException);
  }
}

void main() {
  // Test sum operation
  testSumOperationSuccess();

  // Test division operation
  testDivisionOperationSuccess();
  testDivisionOperationError();
}
