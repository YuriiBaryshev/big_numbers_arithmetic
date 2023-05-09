import 'package:big_numbers_arithmetic/big_numbers_arithmetic.dart' show BigNumberX86;
import 'package:test/test.dart';

void main() {
  group('BigNumberX86:', () {
    test('sets and gets hex from 1 element array', () {
      BigNumberX86 bnx64 = BigNumberX86(32);
      bnx64.setHex("0x12345678");
      expect(bnx64.getHex(), "0x12345678");

      bnx64.setHex("1234");
      expect(bnx64.getHex(), "0x00001234");
      expect(bnx64.getHex(hasLeadingZeroes: false), "0x1234");

      bnx64.setHex("12340");
      expect(bnx64.getHex(), "0x00012340");
      expect(bnx64.getHex(hasLeadingZeroes: false), "0x12340");
    });
  });
}