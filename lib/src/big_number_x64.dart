part of big_numbers_arithmetic;


///Implements BigNumbers arithmetic for x64 platforms
class BigNumberX64 extends BigNumber {
  ///holder of 64 bits parts of data in big-endian format
  late Uint64List data;

  ///creates instance of 64 bit optimized BigNumber
  BigNumberX64(int maxBitLength) {
    if(maxBitLength <= 0) {
      throw ArgumentError("BigNumberX64: maxBitLength must be positive");
    }

    _platform = 64;

    if(maxBitLength % _platform != 0) {
      throw ArgumentError("BigNumberX64: maxBitLength must be dividable by $_platform");
    }

    _maxBitLength = maxBitLength;
    _length = _maxBitLength ~/ _platform;
    data = Uint64List(_length);
  }


  @override
  void _dataFromHex(String hexString) {
    int originalHexStringLength = hexString.length;
    int j = _length - 1;
    for(int i = 0; i < originalHexStringLength; i += 16, j--) {
      if(hexString.length >= 16) {
        data[j] = int.parse(hexString.substring(hexString.length - 16, hexString.length - 8), radix: 16);
        data[j] = data[j] << 32;
        data[j] += int.parse(hexString.substring(hexString.length - 8), radix: 16);
        hexString = hexString.substring(0, hexString.length - 16);
      } else {
        if(hexString.length > 8) {
          print(hexString.substring(0, hexString.length - 8));
          data[j] = int.parse(hexString.substring(0, hexString.length - 8), radix: 16);
          data[j] = data[j] << 32;
          data[j] = int.parse(hexString.substring(hexString.length - 8), radix: 16);
          hexString = "";
        } else {
          data[j] = int.parse(hexString, radix: 16);
          hexString = "";
        }
      }
    }

    for(; j >= 0; j--) {
      data[j] = 0;
    }
  }


  void _increaseLength(int newMaxBitLength) {
    if(newMaxBitLength < maxBitLength) {
      throw ArgumentError("BigNumberX64: unable to reduce variable's length. "
          "It ony can be increased");
    }

    int oldLength = _length;
    Uint64List oldData = Uint64List(_length);


    for(int i = 0; i < _length; i++) {
      oldData[i] = data[i];
    }

    _maxBitLength = newMaxBitLength;
    _length = _maxBitLength ~/ _platform;
    data = Uint64List(_length);

    int delta = _length - oldLength;
    for(int i = 0; i < oldLength; i++) {
      data[i + delta] = oldData[i];
    }

    for(int i = 0; i < delta; i++) {
      data[i] = 0;
    }
  }


  @override
  String getHex({bool has0x = true, bool hasLeadingZeroes = true}) {
    String hex = "";

    for(int i = 0; i < _length; i++) {
      String convertedElement;
      if(data[i].isNegative) {
        convertedElement = (data[i] + 0x8000000000000000).toRadixString(16);
        convertedElement = 'f${convertedElement.substring(1)}';
      } else {
        convertedElement = data[i].toRadixString(16);
      }
      convertedElement = convertedElement.padLeft(16, '0');
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
    return (other is BigNumberX64) && (super == other);
  }


  @override
  BigNumberX64 operator ~() {
    BigNumberX64 output = BigNumberX64(_maxBitLength);
    output.setHex(getHex());
    for(int i = 0; i < _length; i++) {
      output.data[i] = (output.data[i] ^ 0xffffffffffffffff);
    }
    return output;
  }

  
  @override
  BigNumberX64 operator ^(Object other) {
    if (other is! BigNumberX64) {
      throw ArgumentError("BigNumberX64: unable to XOR with other data than BigNumberX64");
    }

    if (other.maxBitLength != maxBitLength) {
      throw FormatException("BigNumberX64: unable to XOR data of $maxBitLength bits with"
          " data of ${other.maxBitLength} bits. Please make sure they have the same length.");
    }

    BigNumberX64 output = BigNumberX64(maxBitLength);
    output.setHex(getHex());
    for(int i = 0; i < _length; i++) {
      output.data[i] = data[i] ^ other.data[i];
    }
    return output;
  }


  @override
  BigNumberX64 operator |(Object other) {
    if (other is! BigNumberX64) {
      throw ArgumentError("BigNumberX64: unable to OR with other data than BigNumberX64");
    }

    if (other.maxBitLength != maxBitLength) {
      throw FormatException("BigNumberX64: unable to OR data of $maxBitLength bits with"
          " data of ${other.maxBitLength} bits. Please make sure they have the same length.");
    }

    BigNumberX64 output = BigNumberX64(maxBitLength);
    output.setHex(getHex());
    for(int i = 0; i < _length; i++) {
      output.data[i] = data[i] | other.data[i];
    }
    return output;
  }


  @override
  BigNumberX64 operator &(Object other) {
    if (other is! BigNumberX64) {
      throw ArgumentError("BigNumberX64: unable to AND with other data than BigNumberX64");
    }

    if (other.maxBitLength != maxBitLength) {
      throw FormatException("BigNumberX64: unable to AND data of $maxBitLength bits with"
          " data of ${other.maxBitLength} bits. Please make sure they have the same length.");
    }

    BigNumberX64 output = BigNumberX64(maxBitLength);
    output.setHex(getHex());
    for(int i = 0; i < _length; i++) {
      output.data[i] = data[i] & other.data[i];
    }
    return output;
  }


  @override
  BigNumberX64 operator >>(int positions) {
    if (positions < 0) {
      throw UnimplementedError("BigNumberX64: shifting on negative positions is not implemented yet");
    }

    if (positions > _maxBitLength) {
      throw ArgumentError("BigNumberX64: shifting more positions then variable length is pointless");
    }

    BigNumberX64 output = BigNumberX64(maxBitLength);
    output.setHex("0");

    int deltaInElements = positions ~/ _platform;
    int elementShift = positions.remainder(_platform);


    for(int i = 0, j = deltaInElements; j < _length; i++, j++) {
      if (data[i].isNegative) {
        output.data[j] = (data[i] + 0x8000000000000000) >> elementShift;
        output.data[j] -= 0x8000000000000000 >> elementShift;
      } else {
        output.data[j] = data[i] >> elementShift;
      }

      if (i > 0) {
        output.data[j] |= data[i - 1] << (_platform - elementShift);
      }
    }
    return output;
  }


  @override
  BigNumberX64 operator <<(int positions) {
    if (positions < 0) {
      throw UnimplementedError("BigNumberX64: shifting on negative positions is not implemented yet");
    }

    if (positions > _maxBitLength) {
      throw UnimplementedError("BigNumberX64: shifting on negative positions is not implemented yet");
    }

    BigNumberX64 output = BigNumberX64(maxBitLength);
    output.setHex("0");

    int deltaInElements = positions ~/ _platform;
    int elementShift = positions.remainder(_platform);

    for(int i = _length - 1, j = _length - 1 - deltaInElements; j >= 0; i--, j--) {
      output.data[j] = data[i] << elementShift;

      if (i < _length - 1) {
        if(data[i+1].isNegative) {
          output.data[j] |= (data[i + 1] + 0x8000000000000000) >> (_platform - elementShift);
          output.data[j] -= 0x8000000000000000 >> (_platform - elementShift);
        } else {
          output.data[j] |= data[i + 1] >> (_platform - elementShift);
        }
      }
    }
    return output;
  }


  @override
  BigNumberX64 operator +(Object other) {
    if (other is! BigNumberX64) {
      throw ArgumentError("BigNumberX64: unable to ADD with other data than BigNumberX64");
    }

    if(other.maxBitLength > maxBitLength) {
      _increaseLength(other.maxBitLength);
    }

    BigNumberX64 output = BigNumberX64(maxBitLength);
    output.setHex("0");
    int carry = 0;
    for(int i = _length - 1, j = other._length - 1; i >= 0; i--, j--) {
      //BigInt seems kinda cheating for the task, but Uint64 is implemented way awfully
      //and I'm way out of time to rewrite it. See x86 implementation to see how the code
      //should look like, when Uint is actually Uint
      late BigInt a = BigInt.from(data[i]),
          b = BigInt.from(j >= 0 ? other.data[j] : 0),
          c = BigInt.from(carry);
      if(data[i].isNegative) {
        a += BigInt.parse("10000000000000000", radix: 16);
      }

      if(other.data[i].isNegative) {
        b += BigInt.parse("10000000000000000", radix: 16);
      }
      int nextCarry  = ((a + b + c) > BigInt.parse("ffffffffffffffff", radix: 16)) ? 1 : 0;
      output.data[i] = data[i] + (j >= 0 ? other.data[j] : 0) + carry;
      carry = nextCarry;
    }

    if(carry == 1) {
      output._increaseLength(maxBitLength + 64);
      output.data[0] = carry;
    }

    return output;
  }

  @override
  BigNumberX64 operator -(Object other) {
    if (other is! BigNumberX64) {
      throw ArgumentError("BigNumberX64: unable to SUB with other data than BigNumberX64");
    }

    if(other.maxBitLength > maxBitLength) {
      _increaseLength(other.maxBitLength);
    }

    BigNumberX64 output = BigNumberX64(maxBitLength);
    output.setHex("0");
    int carry = 0;
    for(int i = _length - 1; i >= 0; i--) {
      //BigInt seems kinda cheating for the task, but Uint64 is implemented way awfully
      late BigInt a = BigInt.from(data[i]),
          b = BigInt.from(other.data[i]),
          c = BigInt.from(carry);
      if(data[i].isNegative) {
        a += BigInt.parse("10000000000000000", radix: 16);
      }

      if(other.data[i].isNegative) {
        b += BigInt.parse("10000000000000000", radix: 16);
      }
      int nextCarry  = ((a - b - c) < BigInt.zero) ? 1 : 0;
      output.data[i] = data[i] - other.data[i] - carry;
      carry = nextCarry;
    }

     return output;
  }


  @override
  bool operator < (Object other) {
    if (other is! BigNumberX64) {
      throw ArgumentError("BigNumberX64: unable to compare with other data than BigNumberX64");
    }

    BigNumberX64 temp = this;
    if(other.maxBitLength < maxBitLength) {
      other._increaseLength(maxBitLength);
      temp = this;
    } else {
      if(other.maxBitLength > maxBitLength) {
        temp._increaseLength(other.maxBitLength);
      }
    }

    for(int i = 0; i < temp._length; i++) {
      if (temp.data[i] == other.data[i]) continue;
      if (temp.data[i] > other.data[i]) {
        return false;
      } else {
        return true;
      }
    }
    return false; //equal
  }

  @override
  bool operator <= (Object other) {
    if (other is! BigNumberX64) {
      throw ArgumentError("BigNumberX64: unable to compare with other data than BigNumberX64");
    }

    BigNumberX64 temp = this;
    if(other.maxBitLength < maxBitLength) {
      other._increaseLength(maxBitLength);
      temp = this;
    } else {
      if(other.maxBitLength > maxBitLength) {
        temp._increaseLength(other.maxBitLength);
      }
    }

    for(int i = 0; i < temp._length; i++) {
      if (temp.data[i] == other.data[i]) continue;
      if (temp.data[i] > other.data[i]) {
        return false;
      } else {
        return true;
      }
    }
    return true; //equal
  }


  @override
  BigNumberX64 operator %(Object other) {
    if (other is! BigNumberX64) {
      throw ArgumentError("BigNumberX64: unable to MOD with other data than BigNumberX64");
    }

    if(this < other) {
      return this;
    }

    BigNumberX64 output = BigNumberX64(maxBitLength);
    output.setHex("0");

    if(this == other) {
      return output;
    }

    output = this;

    while(other < output) {
      output -= other;
    }

    return output;
  }
}