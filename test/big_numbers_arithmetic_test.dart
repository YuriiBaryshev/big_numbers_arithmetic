import 'package:big_numbers_arithmetic/big_numbers_arithmetic.dart';
import 'package:test/test.dart';

void main() {
  group('Negative tests', () {

    test('fails to fit big value into short variable', () {
      BigNumber bn;
      expect(() {
        bn = BigNumberX64(64);
        bn.setHex("1234567890abcdef1");
      },
          throwsArgumentError
      );

      expect(() {
        bn = BigNumberX86(64);
        bn.setHex("1234567890abcdef1");
      },
          throwsArgumentError
      );
    });


    test("fails to create variables of length not dividable by platform's length", () {
      BigNumber bn;
      expect(() {
        bn = BigNumberX64(42); //throws here
        bn.getHex(); //just in order to mute IDE's warning of unused variable
      },
          throwsArgumentError
      );

      expect(() {
        bn = BigNumberX86(42); //throws here
        bn.getHex();  //just in order to mute IDE's warning of unused variable
      },
          throwsArgumentError
      );
    });


    test("fails to create variables of negative length", () {
      BigNumber bn;
      expect(() {
        bn = BigNumberX64(-42); //throws here
        bn.getHex(); //just in order to mute IDE's warning of unused variable
      },
          throwsArgumentError
      );

      expect(() {
        bn = BigNumberX86(-42); //throws here
        bn.getHex();  //just in order to mute IDE's warning of unused variable
      },
          throwsArgumentError
      );
    });


    test("fails to create variables of zero length", () {
      BigNumber bn;
      expect(() {
        bn = BigNumberX64(0); //throws here
        bn.getHex(); //just in order to mute IDE's warning of unused variable
      },
          throwsArgumentError
      );

      expect(() {
        bn = BigNumberX86(0); //throws here
        bn.getHex();  //just in order to mute IDE's warning of unused variable
      },
          throwsArgumentError
      );
    });
  });

  group("Bitwise operations of", () {
    for (String implementation in ["BigNumberX86", "BigNumberX64"]) {
      group(implementation, () {
        late BigNumber bn1, bn2, zero, allOnes, allA, all5,
            allOnesShifted1PositionRight, allOnesShifted42PositionRight;

        setUp(() {
          switch (implementation) {
            case "BigNumberX86" :
              {
                bn1 = BigNumberX86(128);
                bn2 = BigNumberX86(128);
                zero = BigNumberX86(128);
                allOnes = BigNumberX86(128);
                allA = BigNumberX86(128);
                all5 = BigNumberX86(128);
                allOnesShifted1PositionRight = BigNumberX86(128);
                allOnesShifted42PositionRight = BigNumberX86(128);
                break;
              }
            case "BigNumberX64" :
              {
                bn1 = BigNumberX64(128);
                bn2 = BigNumberX64(128);
                zero = BigNumberX64(128);
                allOnes = BigNumberX64(128);
                allA = BigNumberX64(128);
                all5 = BigNumberX64(128);
                allOnesShifted1PositionRight = BigNumberX64(128);
                allOnesShifted42PositionRight = BigNumberX64(128);
                break;
              }
            default:
              throw UnsupportedError(
                  "While testing met unsupported implementation"
                      " of BigNumber $implementation. Please review tests code.");
          }

          bn1.setHex("1");
          bn2.setHex("fffffffffffffffffffffffffffffffe");

          zero.setHex("0");
          allOnes.setHex("ffffffffffffffffffffffffffffffff");

          allA.setHex("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
          all5.setHex("55555555555555555555555555555555");

          allOnesShifted1PositionRight.setHex("7fffffffffffffffffffffffffffffff");
          allOnesShifted42PositionRight.setHex("00000000003fffffffffffffffffffff");
        });


        test("inversion of 128 bit", () {
          expect(~bn1, bn2, reason: "inversion of $bn1 is not equal $bn2");
          expect(~bn2, bn1, reason: "inversion of $bn2 is not equal $bn1");
          expect(~(~bn2), bn2, reason: "double inversion of $bn2 is not equal to"
              " itself");
        });


        test("xor of 128 bit", () {
          expect(zero ^ zero, zero, reason: "$zero ^ $zero is not equal $zero");
          expect(allOnes ^ allOnes, zero, reason: "$allOnes ^ $allOnes is not equal $zero");
          expect(zero ^ allOnes, allOnes, reason: "$zero ^ $allOnes is not equal $zero");

          expect(bn1 ^ bn1, zero, reason: "$bn1 ^ $bn1 is not equal $zero");
          expect(bn2 ^ bn2, zero, reason: "$bn2 ^ $bn2 is not equal $zero");
          expect(bn1 ^ bn2, allOnes, reason: "$bn1 ^ $bn2 is not equal $allOnes");
        });


        test("or of 128 bit", () {
          expect(zero | zero, zero, reason: "$zero | $zero is not equal $zero");
          expect(allOnes | allOnes, allOnes, reason: "$allOnes | $allOnes is not equal $allOnes");
          expect(zero | allOnes, allOnes, reason: "$zero | $allOnes is not equal $allOnes");

          expect(bn1 | bn1, bn1, reason: "$bn1 | $bn1 is not equal $bn1");
          expect(bn2 | bn2, bn2, reason: "$bn2 | $bn2 is not equal $bn2");
          expect(bn1 | bn2, allOnes, reason: "$bn1 | $bn2 is not equal $allOnes");
        });


        test("and of 128 bit", () {
          expect(zero & zero, zero, reason: "$zero & $zero is not equal $zero");
          expect(allOnes & allOnes, allOnes, reason: "$allOnes & $allOnes is not equal $allOnes");
          expect(zero & allOnes, zero, reason: "$zero & $allOnes is not equal $zero");

          expect(bn1 & bn1, bn1, reason: "$bn1 & $bn1 is not equal $bn1");
          expect(bn2 & bn2, bn2, reason: "$bn2 & $bn2 is not equal $bn2");
          expect(bn1 & bn2, zero, reason: "$bn1 & $bn2 is not equal $zero");
        });


        test("shift right for 128 bit", () {
          expect(bn1 >> 1, zero, reason: "$bn1 shifted right 1 position is not equal $zero");
          expect(allOnes >> 1, allOnesShifted1PositionRight, reason: "$allOnes shifted right 1"
              " position is not equal $allOnesShifted1PositionRight");
          expect(allOnes >> 42, allOnesShifted42PositionRight, reason: "$allOnes shifted right 1"
              " position is not equal $allOnesShifted42PositionRight");
          expect(allOnes >> 127, bn1, reason: "$allOnes shifted right 127"
              " position is not equal $bn1");
          expect(allA >> 1, all5, reason: "$allA shifted right 1"
              " position is not equal $all5");
          expect(allA >> 71, all5 >> 70, reason: "$allA shifted right 71"
              " position is not equal $all5 shifted right 70 positions");
        });
      });
    }
  });
}
