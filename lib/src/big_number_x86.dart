part of big_numbers_arithmetic;


///Implements BigNumbers arithmetic for x86 platforms
class BigNumberX86 extends BigNumber {
  ///holder of 32 bits parts of data in big-endian format
  late Uint32List _data;

  ///creates instance of 32 bit optimized BigNumber
  BigNumberX86(int maxBitLength) {
    if(maxBitLength < 0) {
      throw ArgumentError("BigNumberX86: maxBitLength must be positive");
    }

    _platform = 32;

    if(maxBitLength % _platform != 0) {
      throw ArgumentError("BigNumberX86: maxBitLength must be dividable by $_platform");
    }

    _maxBitLength = maxBitLength;
    _length = _maxBitLength ~/ _platform;
    _data = Uint32List(_length);
  }
}