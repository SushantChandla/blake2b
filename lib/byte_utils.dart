///
/// Copyright (c) [2019] [riclava]
/// [blake2b] is licensed under the Mulan PSL v1.
/// You can use this software according to the terms and conditions of the Mulan PSL v1.
/// You may obtain a copy of Mulan PSL v1 at:
///     http://license.coscl.org.cn/MulanPSL
/// THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR
/// PURPOSE.
/// See the Mulan PSL v1 for more details.
///
import 'dart:typed_data';

class ByteUtils {
  static BigInt bytes2long(final Uint8List byteArray, final int offset) {
    // & 0xFF is useless
    return ((BigInt.from(byteArray[offset] & 0xFF)) |
        BigInt.from(((byteArray[offset + 1] & 0xFF) << 8)) |
        BigInt.from(((byteArray[offset + 2] & 0xFF)) << 16) |
        BigInt.from(((byteArray[offset + 3] & 0xFF)) << 24) |
        BigInt.from(((byteArray[offset + 4] & 0xFF)) << 32) |
        BigInt.from(((byteArray[offset + 5] & 0xFF)) << 40) |
        BigInt.from(((byteArray[offset + 6] & 0xFF)) << 48) |
        BigInt.from(((byteArray[offset + 7] & 0xFF)) << 56));
  }

  static Uint8List long2bytes(final BigInt longValue) =>
      _bigIntToByteData(longValue).buffer.asUint8List();

  static ByteData _bigIntToByteData(BigInt bigInt) {
    final data = ByteData((bigInt.bitLength / 8).ceil());
    var _bigInt = bigInt;
    for (var i = 1; i <= data.lengthInBytes; i++) {
      data.setUint8(data.lengthInBytes - i, _bigInt.toUnsigned(8).toInt());
      _bigInt = _bigInt >> 8;
    }
    return data;
  }

  static BigInt rotr64(final BigInt x, final int rot) {
    //bug here
    return x >> rot | x << (64 - rot);
  }
}
