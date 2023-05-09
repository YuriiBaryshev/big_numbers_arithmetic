import 'package:big_numbers_arithmetic/big_numbers_arithmetic.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {

    test('fails to fit big value into short variable', ()
    {
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


    test("fails to create variables of length not dividable by platform's length", ()
    {
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


    test("fails to create variables of negative length", ()
    {
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

    test("fails to create variables of zero length", ()
    {
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
}
