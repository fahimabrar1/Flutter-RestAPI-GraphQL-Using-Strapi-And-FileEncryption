import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as enc;

///
/// Uses this model to story a 256 bit key for Encryption and decryption
///

class MyEncrypt {
  static final myKey = enc.Key.fromUtf8('&E)H@McQfTjWnZr4u7w!z%C*F-JaNdRg');
  static final myIv = enc.IV.fromLength(16);
  static final myEncrypter = enc.Encrypter(enc.AES(myKey));
}

///
/// uses to return a file as byte wit hname
///

class DecryptModel {
  Uint8List uint8list;
  String fileName;

  DecryptModel(this.uint8list, this.fileName);
}
