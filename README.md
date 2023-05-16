# Big number arithmetic
Package that implements big numbers arithmetic for Dart language

## Features

Implements `BigNumberX86` and `BigNumberX64` data types as well as implemnetation design pattern factory method for quick usage of these types.

Features supported for BigNumberX86:
1. 'getHex' - with options for adding `0x` encoding marker and showing/hiding leading zeros
2. 'setHex' - irrelevant to presence or absence of `0x` marker
3. '~'  inversion operator
4. '^' XOR operator
5. '|' or operator
6. '&' and operator
7. '>>' rightwise linear shift operator
8. '<<' leftwise lenear shift operator
9. '+' add operator
10. '-' subtract operator
11. '<' lesser operator
12. '<=' lesser equal operator
13. '==' equal operator
14. '%' getting reminder operator
15. '*' multiplicaton operator

Features supported for BigNumberX64:
1. 'getHex' - with options for adding `0x` encoding marker and showing/hiding leading zeros
2. 'setHex' - irrelevant to presence or absence of `0x` marker
3. '~'  inversion operator
4. '^' XOR operator
5. '|' or operator
6. '&' and operator
7. '>>' rightwise linear shift operator
8. '<<' leftwise lenear shift operator
9. '+' add operator
10. '-' subtract operator
11. '<' lesser operator
12. '<=' lesser equal operator
13. '==' equal operator
14. '%' getting reminder operator

Method factory has such methods:
1. createBigNumberX86
2. createBigNumberX64
3. createBigNumber

In order to use `createBigNumber` one should pass `Platform`'s value (which in enumaration declared within the library). 

## Getting started

1. Install Dart SDK and Flutter framework.
2. Install IDE (this was developed using Android studio, but any Dart-supporting will do).
3. Run command `flutter test` in project's folder in order to see that every thing is alright (all tests passed).

## Usage

```dart
  BigNumber a = BigNumberFactoryMethod.createBigNumberX86(256);
  BigNumberX86 b = BigNumberFactoryMethod.createBigNumber(Platforms.x86, 256);
  a.setHex("51bf608414ad5726a3c1bec098f77b1b54ffb2787f8d528a74c1d7fde6470ea4");
  b.setHex("403db8ad88a3932a0b7e8189aed9eeffb8121dfac05c3512fdb396dd73f6331c");
  BigNumberX86 c = (a ^ b) as BigNumberX86;
  print(c); // 1182d8299c0ec40ca8bf3f49362e95e4ecedaf82bfd167988972412095b13db8
```
