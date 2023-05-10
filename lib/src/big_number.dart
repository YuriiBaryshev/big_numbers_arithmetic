part of big_numbers_arithmetic;


///parent class for platform optimized BigNumbers
abstract class BigNumber {
  ///maximum variable length in bits
  late int _maxBitLength;
  int get maxBitLength => _maxBitLength;

  ///maximum variable length in platform dependant blocks
  late int _length;

  ///platform bits length
  late int _platform;

  ///setting data by hexadecimal string
  void setHex(String hexString) {
    //strip '0x' hexadecimal notation if applicable
    if ((hexString.length >= 2) && (hexString.substring(0, 2) == "0x")) {
      hexString = hexString.substring(2);
    }

    //validate input
    RegExp hexAlphabet = RegExp(r"^[a-f0-9]", caseSensitive: false);
    if (!hexAlphabet.hasMatch(hexString)) {
      throw ArgumentError("BigNumber: cannot convert hex string into BigNumber "
          "platform specific implementation due to restricted symbols for hexadecimal"
          " number encoding alphabet within inputted string");
    }

    //check whenever inputted string is fitting variable's length
    if (hexString.length > (_maxBitLength >> 2)) {
      throw ArgumentError("BigNumber: provided hex string is longer then "
          "this variable's maxBitLength ($_maxBitLength). Try to create another "
          "instance of class with at least ${hexString.length << 2} maxBitLength");
    }

    //platform specific conversion
    _dataFromHex(hexString);
  }


  ///converting hex string into platform specific data array
  void _dataFromHex(String hexString);


  ///getting data in hexadecimal string format
  String getHex({bool has0x = true, bool hasLeadingZeroes = true});


  @override
  String toString() {
    return getHex(has0x: false);
  }


  @override
  bool operator == (Object other) =>
      (other is BigNumber) && (getHex() == other.getHex());

  @override
  int get hashCode;

  BigNumber operator ~();

  BigNumber operator ^(Object other);

  BigNumber operator |(Object other);

  BigNumber operator &(Object other);

}