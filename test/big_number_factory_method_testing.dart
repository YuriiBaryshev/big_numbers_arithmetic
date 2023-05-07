import 'package:big_numbers_arithmetic/big_numbers_arithmetic.dart' show BigNumberFactoryMethod, Platforms;
import 'package:test/test.dart';

void main() {
  group('BigNumberFactoryMethod:', () {
    test('throws on passing unknown platform argument', () {
      expect(() {
        BigNumberFactoryMethod.createBigNumber(Platforms.avr8bit, 256);
      },
          throwsUnimplementedError
      );
    });
  });
}