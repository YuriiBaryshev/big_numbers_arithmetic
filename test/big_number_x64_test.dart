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

      bn.setHex("12340");
      expect(bn.getHex(), "0x0000000000012340");
      expect(bn.getHex(hasLeadingZeroes: false), "0x12340");
    });


      bnx64.setHex("1234");
      expect(bnx64.getHex(), "0x0000000000001234");
      expect(bnx64.getHex(hasLeadingZeroes: false), "0x1234");

      bn.setHex("1234");
      expect(bn.getHex(), "0x00000000000000000000000000001234");
      expect(bn.getHex(hasLeadingZeroes: false), "0x1234");

      bn.setHex("12340");
      expect(bn.getHex(), "0x00000000000000000000000000012340");
      expect(bn.getHex(hasLeadingZeroes: false), "0x12340");
    });
  });
}