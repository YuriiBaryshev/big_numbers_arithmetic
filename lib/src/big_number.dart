part of big_numbers_arithmetic;


///parent class for platform optimized BigNumbers
abstract class BigNumber {
  ///maximum variable length in bits
  late int _maxBitLength;

  ///maximum variable length in platform dependant blocks
  late int _length;

  ///platform bits length
  late int _platform;
}