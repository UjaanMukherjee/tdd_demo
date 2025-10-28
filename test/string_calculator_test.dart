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

  test('Adding multiple numbers', () {
    final result = calculator.add('1,2');
    final result2 = calculator.add('3,4,5');
    expect(result, 3);
    expect(result2, 12);
  });

  test('Adding numbers with "\\n" delimiter', () {
    final result = calculator.add('1\n2,3');
    expect(result, 6);
  });

  test('Adding numbers with custom delimiter', () {
    final result = calculator.add('//;\n1;2');
    final result2 = calculator.add('//[add]\n3add4');
    expect(result, 3);
    expect(result2, 7);
  });
}
