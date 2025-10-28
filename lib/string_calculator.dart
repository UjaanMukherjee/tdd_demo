class StringCalculator {
  int add(String numbers) {
    String delimiter = r'[,\n|]+';
    String formattedInput = numbers;
    if (numbers.startsWith('//')) {
      // if we detect custom delimiter we split and get substring to access the delimiter
      final parts = numbers.split('\n');
      String customDelimiter = parts[0].substring(2);
      // handle case for delimiters wrapped in []
      customDelimiter =
          customDelimiter.startsWith('[') && customDelimiter.endsWith(']')
              ? customDelimiter.substring(1, customDelimiter.length - 1)
              : customDelimiter;
      // update the delimiter regex to include custom delimiter
      delimiter = RegExp.escape(customDelimiter) + r'|,|\n';
      // remove the custom delimiter syntax from the input
      formattedInput = parts.sublist(1).join('\n');
    }
    final parts = formattedInput.split(RegExp(delimiter));
    int sum = 0;
    for (var part in parts) {
      if (part.isNotEmpty) {
        final number = int.parse(part);
        if (number < 0) {
          throw FormatException('negative numbers are not allowed');
        }
        sum += number;
      }
    }
    return sum;
  }
}
