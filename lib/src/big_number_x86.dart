part of big_numbers_arithmetic;


///Implements BigNumbers arithmetic for x86 platforms
class BigNumberX86 extends BigNumber {
  ///holder of 32 bits parts of data in big-endian format
  late Uint32List data;

  ///creates instance of 32 bit optimized BigNumber
  BigNumberX86(int maxBitLength) {
    if(maxBitLength <= 0) {
      throw ArgumentError("BigNumberX86: maxBitLength must be positive");
    }

    _platform = 32;

    if(maxBitLength % _platform != 0) {
      throw ArgumentError("BigNumberX86: maxBitLength must be dividable by $_platform");
    }

    _maxBitLength = maxBitLength;
    _length = _maxBitLength ~/ _platform;
    data = Uint32List(_length);
  }


  @override
  void _dataFromHex(String hexString) {
    int originalHexStringLength = hexString.length;
    int j = _length - 1;
    for(int i = 0; i < originalHexStringLength; i += 8, j--) {
      if(hexString.length >= 8) {
        data[j] = int.parse(hexString.substring(hexString.length - 8), radix: 16);
        hexString = hexString.substring(0, hexString.length - 8);
      } else {
        data[j] = int.parse(hexString, radix: 16);
        hexString = "";
      }
    }

    for(; j >= 0; j--) {
      data[j] = 0;
    }
  }


  @override
  String getHex({bool has0x = true, bool hasLeadingZeroes = true}) {
    String hex = "";

    for(int i = 0; i < _length; i++) {
      String convertedElement = data[i].toRadixString(16);
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


  @override
  int get hashCode {
    int hash = Object.hash(_length, _maxBitLength, _platform);
    hash ^= Object.hashAll(data);
    return hash;
  }

  @override
  bool operator ==(Object other) {
    return (other is BigNumberX86) && (super == other);
  }


  @override
  BigNumberX86 operator ~() {
    BigNumberX86 output = BigNumberX86(_maxBitLength);
    output.setHex(getHex());
    for(int i = 0; i < _length; i++) {
      output.data[i] = output.data[i] ^ 0xffffffff;
    }
    return output;
  }

  @override
  BigNumberX86 operator ^(Object other) {
    if (other is! BigNumberX86) {
      throw ArgumentError("BigNumberX86: unable to XOR with other data than BigNumberX86");
    }

    if (other.maxBitLength != maxBitLength) {
      throw FormatException("BigNumberX86: unable to XOR data of $maxBitLength bits with"
          " data of ${other.maxBitLength} bits. Please make sure they have the same length.");
    }

    BigNumberX86 output = BigNumberX86(maxBitLength);
    output.setHex(getHex());
    for(int i = 0; i < _length; i++) {
      output.data[i] = data[i] ^ other.data[i];
    }
    return output;
  }


  @override
  BigNumberX86 operator |(Object other) {
    if (other is! BigNumberX86) {
      throw ArgumentError("BigNumberX86: unable to OR with other data than BigNumberX86");
    }

    if (other.maxBitLength != maxBitLength) {
      throw FormatException("BigNumberX86: unable to OR data of $maxBitLength bits with"
          " data of ${other.maxBitLength} bits. Please make sure they have the same length.");
    }

    BigNumberX86 output = BigNumberX86(maxBitLength);
    output.setHex(getHex());
    for(int i = 0; i < _length; i++) {
      output.data[i] = data[i] | other.data[i];
    }
    return output;
  }


  @override
  BigNumberX86 operator &(Object other) {
    if (other is! BigNumberX86) {
      throw ArgumentError("BigNumberX86: unable to AND with other data than BigNumberX86");
    }

    if (other.maxBitLength != maxBitLength) {
      throw FormatException("BigNumberX86: unable to AND data of $maxBitLength bits with"
          " data of ${other.maxBitLength} bits. Please make sure they have the same length.");
    }

    BigNumberX86 output = BigNumberX86(maxBitLength);
    output.setHex(getHex());
    for(int i = 0; i < _length; i++) {
      output.data[i] = data[i] & other.data[i];
    }
    return output;
  }
}