import 'package:big_numbers_arithmetic/big_numbers_arithmetic.dart' show BigNumberX64;
import 'package:test/test.dart';

void main() {
  group('BigNumberX64:', () {
    test('sets and gets hex from 1 element array', () {
      BigNumberX64 bnx64 = BigNumberX64(64);
      bnx64.setHex("0x1234567812345678");
      expect(bnx64.getHex(), "0x1234567812345678");

      bnx64.setHex("1234");
      expect(bnx64.getHex(), "0x0000000000001234");
      expect(bnx64.getHex(hasLeadingZeroes: false), "0x1234");

      bnx64.setHex("12340");
      expect(bnx64.getHex(), "0x0000000000012340");
      expect(bnx64.getHex(hasLeadingZeroes: false), "0x12340");
    });
  });
}