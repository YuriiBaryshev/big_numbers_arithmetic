import 'package:big_numbers_arithmetic/big_numbers_arithmetic.dart';

void main() {
  BigNumber a = BigNumberFactoryMethod.createBigNumberX86(256);
  BigNumberX86 b = BigNumberFactoryMethod.createBigNumber(Platforms.x86, 256);
  a.setHex("51bf608414ad5726a3c1bec098f77b1b54ffb2787f8d528a74c1d7fde6470ea4");
  b.setHex("403db8ad88a3932a0b7e8189aed9eeffb8121dfac05c3512fdb396dd73f6331c");
  BigNumberX86 c = (a ^ b) as BigNumberX86;
  print(c);
}
