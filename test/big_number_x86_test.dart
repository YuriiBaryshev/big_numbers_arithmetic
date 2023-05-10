import 'package:big_numbers_arithmetic/big_numbers_arithmetic.dart' show BigNumberX86;
import 'package:test/test.dart';

void main() {
  group('BigNumberX86:', () {
    group('set/getHex tests', ()
    {
      test('sets and gets hex from 1 element array', () {
        BigNumberX86 bn = BigNumberX86(32);
        bn.setHex("0x12345678");
        expect(bn.getHex(), "0x12345678");

        bn.setHex("1234");
        expect(bn.getHex(), "0x00001234");
        expect(bn.getHex(hasLeadingZeroes: false), "0x1234");
        expect(bn.getHex(has0x: false, hasLeadingZeroes: false), "1234");
        expect(bn.getHex(has0x: false, hasLeadingZeroes: true), "00001234");

        bn.setHex("12340");
        expect(bn.getHex(), "0x00012340");
        expect(bn.getHex(hasLeadingZeroes: false), "0x12340");
      });


      test('sets and gets hex from 2 element array', () {
        BigNumberX86 bn = BigNumberX86(64);
        bn.setHex("0x1234567812345678");
        expect(bn.getHex(), "0x1234567812345678");

        bn.setHex("1234");
        expect(bn.getHex(), "0x0000000000001234");
        expect(bn.getHex(hasLeadingZeroes: false), "0x1234");
        expect(bn.getHex(has0x: false), "0000000000001234");
        expect(bn.getHex(has0x: false, hasLeadingZeroes: false), "1234");


        bn.setHex("12340");
        expect(bn.getHex(), "0x0000000000012340");
        expect(bn.getHex(hasLeadingZeroes: false), "0x12340");
      });


      test('sets and gets hex for 256 bits data', () {
        BigNumberX86 bn = BigNumberX86(256);
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
        BigNumberX86 bn = BigNumberX86(2048);
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


    test("multiplies digits", () {
      BigNumberX86 a = BigNumberX86(32);
      BigNumberX86 b = BigNumberX86(32);

      BigNumberX86 result = BigNumberX86(64);

      a.setHex("2");
      b.setHex("55555555");
      result.setHex("00000000aaaaaaaa");

      expect(a * b, result, reason: "$a * $b is not equal to $result");
    });


    test("multiplies digits from given test case", () {
      BigNumberX86 a = BigNumberX86(128);
      BigNumberX86 b = BigNumberX86(128);

      BigNumberX86 result = BigNumberX86(256);

      a.setHex("7d7deab2affa38154326e96d350deee1");
      b.setHex("97f92a75b3faf8939e8e98b96476fd22");
      result.setHex("4a7f69b908e167eb0dc9af7bbaa5456039c38359e4de4f169ca10c44d0a416e2");

      expect(a * b, result, reason: "$a * $b is not equal to $result");
    });
  });
}