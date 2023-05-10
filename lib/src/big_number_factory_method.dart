part of big_numbers_arithmetic;

///Determines platform types for the BigNumberFactoryMethod.createBigNumber(...) method
enum Platforms {
  x86,      //32 bit
  x64,      //64 bit
  avr8bit,  //8 bit
}

/// Implements Factory Method design pattern for BigNumber data type.
class BigNumberFactoryMethod {
  ///Constructor shouldn't be called
  BigNumberFactoryMethod() {
    throw UnsupportedError("BigNumberFactoryMethod: one shouldn't create an instance "
        "of factory method in order to create a class. The creation methods are static,"
        " so the proper way of their usage is to call them directly");
  }


  ///Creates an instance of 32 bit based BigNumber for x86 or any other 32 bit
  ///based platforms
  static BigNumberX86 createBigNumberX86(int maxBitLength) {
    return BigNumberX86(maxBitLength);
  }


  ///Creates an instance of 64 bit based BigNumber for x64 or any other 64 bit
  ///based platform
  static BigNumberX64 createBigNumberX64(int maxBitLength) {
    return BigNumberX64(maxBitLength);
  }


  ///Creates an instance BigNumber optimized for @platform argument
  static createBigNumber(Platforms platform, int maxBitLength) {
    switch(platform) {
      case Platforms.x86 : {
        return createBigNumberX86(maxBitLength);
      }

      case Platforms.x64 : {
        return createBigNumberX64(maxBitLength);
      }

      default : {
        throw UnimplementedError("BigNumberFactoryMethod: unimplemented platform $platform was passed");
      }
    }
  }
}
