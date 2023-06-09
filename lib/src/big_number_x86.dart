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


  void _increaseLength(int newMaxBitLength) {
    if(newMaxBitLength < maxBitLength) {
      throw ArgumentError("BigNumberX86: unable to reduce variable's length. "
          "It ony can be increased");
    }

    int oldLength = _length;
    Uint32List oldData = Uint32List(_length);


    for(int i = 0; i < _length; i++) {
      oldData[i] = data[i];
    }

    _maxBitLength = newMaxBitLength;
    _length = _maxBitLength ~/ _platform;
    data = Uint32List(_length);

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


  @override
  BigNumberX86 operator >>(int positions) {
    if (positions < 0) {
      throw UnimplementedError("BigNumberX86: shifting on negative positions is not implemented yet");
    }

    if (positions > _maxBitLength) {
      throw ArgumentError("BigNumberX86: shifting more positions then variable length is pointless");
    }

    BigNumberX86 output = BigNumberX86(maxBitLength);
    output.setHex("0");

    int deltaInElements = positions ~/ _platform;
    int elementShift = positions % _platform;

    for(int i = 0, j = deltaInElements; j < _length; i++, j++) {
      output.data[j] = data[i] >> elementShift;
      if (i > 0) {
        output.data[j] |= data[i - 1] << (_platform - elementShift);
      }
    }
    return output;
  }


  @override
  BigNumberX86 operator <<(int positions) {
    if (positions < 0) {
      throw UnimplementedError("BigNumberX86: shifting on negative positions is not implemented yet");
    }

    if (positions > _maxBitLength) {
      throw UnimplementedError("BigNumberX86: shifting on negative positions is not implemented yet");
    }

    BigNumberX86 output = BigNumberX86(maxBitLength);
    output.setHex("0");

    int deltaInElements = positions ~/ _platform;
    int elementShift = positions.remainder(_platform);

    for(int i = _length - 1, j = _length - 1 - deltaInElements; j >= 0; i--, j--) {
      output.data[j] = data[i] << elementShift;

      if (i < _length - 1) {
        output.data[j] |= data[i + 1] >> (_platform - elementShift);
      }
    }
    return output;
  }


  @override
  BigNumberX86 operator +(Object other) {
    if (other is! BigNumberX86) {
      throw ArgumentError("BigNumberX86: unable to ADD with other data than BigNumberX86");
    }

    if(other.maxBitLength > maxBitLength) {
      _increaseLength(other.maxBitLength);
    }

    BigNumberX86 output = BigNumberX86(maxBitLength);
    output.setHex("0");
    int carry = 0;
    for(int i = _length - 1, j = other._length - 1; i >= 0; i--, j--) {
      int nextCarry  = ((data[i] + (j >= 0 ? other.data[j] : 0) + carry) > 0xffffffff) ? 1 : 0;
      output.data[i] = data[i] + (j >= 0 ? other.data[j] : 0) + carry;
      carry = nextCarry;
    }

    if(carry == 1) {
      output._increaseLength(maxBitLength + 32);
      output.data[0] = carry;
    }

    return output;
  }


  @override
  BigNumberX86 operator -(Object other) {
    if (other is! BigNumberX86) {
      throw ArgumentError("BigNumberX86: unable to SUB with other data than BigNumberX86");
    }

    if(other.maxBitLength > maxBitLength) {
      _increaseLength(other.maxBitLength);
    }

    BigNumberX86 output = BigNumberX86(maxBitLength);
    output.setHex("0");
    int carry = 0;
    for(int i = _length - 1, j = other._length - 1; i >= 0; i--, j--) {
      int nextCarry  = ((data[i] - (j >= 0 ? other.data[j] : 0) - carry) < 0) ? 1 : 0;
      output.data[i] = data[i] - (j >= 0 ? other.data[j] : 0) - carry;
      carry = nextCarry;
    }

    return output;
  }


  @override
  bool operator < (Object other) {
    if (other is! BigNumberX86) {
      throw ArgumentError("BigNumberX86: unable to compare with other data than BigNumberX86");
    }

    BigNumberX86 temp = this;
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
    if (other is! BigNumberX86) {
      throw ArgumentError("BigNumberX86: unable to compare with other data than BigNumberX86");
    }

    BigNumberX86 temp = this;
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
  BigNumberX86 operator %(Object other) {
    if (other is! BigNumberX86) {
      throw ArgumentError("BigNumberX86: unable to MOD with other data than BigNumberX86");
    }

    BigNumberX86 output = BigNumberX86(maxBitLength);
    output.setHex("0");

    if(this == other) {
      return output;
    }

    output = this;

    if(this < other) {
      return output;
    }

    while(other <= output) {
      output -= other;
    }

    return output;
  }


  @override
  BigNumberX86 operator *(Object other) {
    if (other is! BigNumberX86) {
      throw ArgumentError("BigNumberX86: unable to MOD with other data than BigNumberX86");
    }

    BigNumberX86 output = BigNumberX86(maxBitLength << 1);
    output.setHex("0");

    //binary algorithm
    for(int i = 0; i < _length; i++) {
      int mask = 0x80000000;
      for(; mask != 0; mask = mask >> 1) {
        output += output;
        if(other.data[i] & mask != 0) {
          output += this;
        }
      }
    }
    return output;
  }
}