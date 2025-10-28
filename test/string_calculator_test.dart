import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_demo/string_calculator.dart';

void main() {
  late final StringCalculator calculator;
  setUpAll(() {
    calculator = StringCalculator();
  });
  test('Adding with empty string', () {
    final result = calculator.add('');
    expect(result, 0);
  });

  test('Adding single number', () {
    final result = calculator.add('1');
    expect(result, 1);
  });

  test('Adding two numbers', () {
    final result = calculator.add('1,2');
    expect(result, 3);
  });
}
