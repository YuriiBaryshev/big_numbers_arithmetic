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


  @override
  void _dataFromHex(String hexString) {
    int originalHexStringLength = hexString.length;
    int j = _length - 1;
    for(int i = 0; i < originalHexStringLength; i += 16, j--) {
      if(hexString.length >= 16) {
        _data[j] = int.parse(hexString.substring(hexString.length - 16, hexString.length - 8), radix: 16);
        _data[j] = _data[j] << 32;
        _data[j] += int.parse(hexString.substring(hexString.length - 8), radix: 16);
        hexString = hexString.substring(0, hexString.length - 16);
      } else {
        if(hexString.length > 8) {
          print(hexString.substring(0, hexString.length - 8));
          _data[j] = int.parse(hexString.substring(0, hexString.length - 8), radix: 16);
          _data[j] = _data[j] << 32;
          _data[j] = int.parse(hexString.substring(hexString.length - 8), radix: 16);
          hexString = "";
        } else {
          _data[j] = int.parse(hexString, radix: 16);
          hexString = "";
        }
      }
    }

    for(; j > 0; j--) {
      _data[j] = 0;
    }
  }




}