import 'package:big_numbers_arithmetic/big_numbers_arithmetic.dart' show BigNumberX64;
import 'package:test/test.dart';

void main() {
  group('BigNumberX64:', () {
    group('set/getHex tests:', ()
    {
      test('sets and gets hex from 1 element array', () {
        BigNumberX64 bn = BigNumberX64(64);
        bn.setHex("0x1234567812345678");
        expect(bn.getHex(), "0x1234567812345678");

        bn.setHex("1234");
        expect(bn.getHex(), "0x0000000000001234");
        expect(bn.getHex(hasLeadingZeroes: false), "0x1234");
        expect(bn.getHex(has0x: false, hasLeadingZeroes: false), "1234");
        expect(bn.getHex(has0x: false, hasLeadingZeroes: true),
            "0000000000001234");

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


      test('sets and gets hex for 256 bits data', () {
        BigNumberX64 bn = BigNumberX64(256);
        bn.setHex("0x123456781234567809abcdef09abcdef");
        expect(bn.getHex(hasLeadingZeroes: false),
            "0x123456781234567809abcdef09abcdef");

        bn.setHex(
            "123456781234567809abcdef09abcdef123456781234567809abcdef09abcdef");
        expect(
            bn.getHex(hasLeadingZeroes: false),
            "0x123456781234567809abcdef09abcdef123456781234567809abcdef09abcdef"
        );
      });


      test('sets and gets hex for 2048 bits data', () {
        BigNumberX64 bn = BigNumberX64(2048);
        bn.setHex(
            "0x123456781234567809abcdef09abcdef123456781234567809abcdef09abc"
                "def123456781234567809abcdef09abcdef123456781234567809abcdef09abcdef12"
                "3456781234567809abcdef09abcdef123456781234567809abcdef09abcdef1234567"
                "81234567809abcdef09abcdef123456781234567809abcdef09abcdef123456781234"
                "567809abcdef09abcdef123456781234567809abcdef09abcdef12345678123456780"
                "9abcdef09abcdef123456781234567809abcdef09abcdef123456781234567809abcd"
                "ef09abcdef123456781234567809abcdef09abcdef123456781234567809abcdef09a"
                "bcdef123456781234567809abcdef09abcdef"
        );

        expect(bn.getHex(),
            "0x123456781234567809abcdef09abcdef123456781234567809abcdef09abc"
                "def123456781234567809abcdef09abcdef123456781234567809abcdef09abcdef12"
                "3456781234567809abcdef09abcdef123456781234567809abcdef09abcdef1234567"
                "81234567809abcdef09abcdef123456781234567809abcdef09abcdef123456781234"
                "567809abcdef09abcdef123456781234567809abcdef09abcdef12345678123456780"
                "9abcdef09abcdef123456781234567809abcdef09abcdef123456781234567809abcd"
                "ef09abcdef123456781234567809abcdef09abcdef123456781234567809abcdef09a"
                "bcdef123456781234567809abcdef09abcdef");
      });
    });

    group('Bitwise operations', () {
      test("inversion of 128 bit", () {
        BigNumberX64 bn1 = BigNumberX64(128);
        BigNumberX64 bn2 = BigNumberX64(128);
        bn1.setHex("1");
        bn2.setHex("fffffffffffffffffffffffffffffffe");

        expect(~bn1, bn2, reason: "${(~bn1).getHex()} is not equal ${bn2.getHex()}");
        expect(bn1, (~bn2), reason: "${bn1.getHex()} is not equal ${(~bn2).getHex()}");
        expect(bn2, ~(~bn2), reason: "${(~(~bn2)).getHex()} is not equal ${bn2.getHex()}");
      });
    });
  });
}