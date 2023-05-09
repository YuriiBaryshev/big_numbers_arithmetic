import 'package:big_numbers_arithmetic/big_numbers_arithmetic.dart' show BigNumberX64;
import 'package:test/test.dart';

void main() {
  group('BigNumberX64:', () {
    test('sets and gets hex from 1 element array', () {
      BigNumberX64 bn = BigNumberX64(64);
      bn.setHex("0x1234567812345678");
      expect(bn.getHex(), "0x1234567812345678");

      bn.setHex("1234");
      expect(bn.getHex(), "0x0000000000001234");
      expect(bn.getHex(hasLeadingZeroes: false), "0x1234");
      expect(bn.getHex(has0x: false, hasLeadingZeroes: false), "1234");
      expect(bn.getHex(has0x: false, hasLeadingZeroes: true), "0000000000001234");

      bn.setHex("12340");
      expect(bn.getHex(), "0x0000000000012340");
      expect(bn.getHex(hasLeadingZeroes: false), "0x12340");
    });


    test('sets and gets hex from 2 element array', () {
      BigNumberX64 bn = BigNumberX64(128);
      bn.setHex("0x123456781234567809abcdef09abcdef");
      expect(bn.getHex(), "0x123456781234567809abcdef09abcdef");

      bn.setHex("1234");
      expect(bn.getHex(), "0x00000000000000000000000000001234");
      expect(bn.getHex(hasLeadingZeroes: false), "0x1234");
      expect(bn.getHex(has0x: false, hasLeadingZeroes: false), "1234");
      expect(
          bn.getHex(has0x: false, hasLeadingZeroes: true),
          "00000000000000000000000000001234"
      );

      bn.setHex("12340");
      expect(bn.getHex(), "0x00000000000000000000000000012340");
      expect(bn.getHex(hasLeadingZeroes: false), "0x12340");
    });
  });
}