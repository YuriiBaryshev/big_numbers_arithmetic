import 'package:big_numbers_arithmetic/big_numbers_arithmetic.dart' show BigNumberFactoryMethod, Platforms;
import 'package:test/test.dart';

void main() {
  group('BigNumberFactoryMethod:', () {
    test('throws on attempt to create an instance of BigNumberFactoryMethod', () {
      expect(() {
        BigNumberFactoryMethod bigNumberFactoryMethod = BigNumberFactoryMethod(); //must throw
        print(bigNumberFactoryMethod.hashCode); //shouldn't ever be called
      },
          throwsUnsupportedError
      );
    });


    test('throws on passing unknown platform argument', () {
      expect(() {
        BigNumberFactoryMethod.createBigNumber(Platforms.avr8bit, 256);
      },
          throwsUnimplementedError
      );
    });
  });
}