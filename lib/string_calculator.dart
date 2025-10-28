class StringCalculator {
  int add(String numbers) {
    final delimiter = RegExp(r'[,\n]+');
    final parts = numbers.split(delimiter);
    int sum = 0;
    for (var part in parts) {
      if (part.isNotEmpty) {
        sum += int.parse(part);
      }
    }
    return sum;
  }
}
