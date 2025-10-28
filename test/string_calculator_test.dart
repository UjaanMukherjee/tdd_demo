import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_demo/string_calculator.dart';

void main() {
  test('String calculator test', () {
    final calculator = StringCalculator();
    expect(calculator.add(''), 0);
  });
}
