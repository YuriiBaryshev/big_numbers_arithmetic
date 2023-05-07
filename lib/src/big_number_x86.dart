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


  @override
  void _dataFromHex(String hexString) {
    int originalHexStringLength = hexString.length;
    int j = _length - 1;
    for(int i = 0; i < originalHexStringLength; i += 8, j--) {
      if(hexString.length >= 8) {
        _data[j] = int.parse(hexString.substring(hexString.length - 8), radix: 16);
        hexString = hexString.substring(0, hexString.length - 8);
      } else {
        _data[j] = int.parse(hexString, radix: 16);
        hexString = "";
      }
    }

    for(; j > 0; j--) {
      _data[j] = 0;
    }
  }


  @override
  String getHex({bool has0x = true, bool hasLeadingZeroes = true}) {
    String hex = "";

    for(int i = 0; i < _length; i++) {
      String convertedElement = _data[i].toRadixString(16);
      convertedElement = convertedElement.padLeft(8, '0');
      hex += convertedElement;
    }

    if(!hasLeadingZeroes) {
      hex = hex.replaceFirst(RegExp(r'^0+'), '');
    }

    if(has0x) {
      hex = "0x$hex";
    }

    return hex;
  }
}