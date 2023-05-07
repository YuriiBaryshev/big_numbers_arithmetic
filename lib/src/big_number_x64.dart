part of big_numbers_arithmetic;


///Implements BigNumbers arithmetic for x64 platforms
class BigNumberX64 extends BigNumber {
  ///holder of 64 bits parts of data in big-endian format
  late Uint64List _data;

  ///creates instance of 64 bit optimized BigNumber
  BigNumberX64(int maxBitLength) {
    if(maxBitLength < 0) {
      throw ArgumentError("BigNumberX64: maxBitLength must be positive");
    }

    _platform = 64;

    if(maxBitLength % _platform != 0) {
      throw ArgumentError("BigNumberX64: maxBitLength must be dividable by $_platform");
    }

    _maxBitLength = maxBitLength;
    _length = _maxBitLength ~/ _platform;
    _data = Uint64List(_length);
  }
}