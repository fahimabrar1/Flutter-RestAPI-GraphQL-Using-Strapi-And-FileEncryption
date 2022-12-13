import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:strapy_flutter/File%20Encryption/model/my_encrypt_model.dart';
import 'package:strapy_flutter/File%20Encryption/model/strapi_filedownloader_model.dart';

class MyAppFileHandler {
  ///
  /// Downloads and encrypts any file
  ///
  /// takes host a [host], api [api] and directory [d]
  ///

  void downloadAndCreate(String host, String api, Directory d) async {
    // fetches the file data from the strapi api
    var resp = await http.get(Uri.parse("$host$api"));
    log("response: ${resp.body}");

    // converts files model from json
    var responseBody = strapiFileDownloaderModelFromJson(resp.body);

    // fetches the file download url from model
    String fileUrl =
        "$host${responseBody.data.attributes.image.data.attributes.url}";

    //Todo: As api is not live, commenting the url check
    // * if (await canLaunchUrl(Uri.parse(fileUrl))) {

    // downloads the file from [fileUrl]

    var fileResponse = await http.get(Uri.parse(fileUrl));
    log("Data downloading....");
    // encrypts the file file response
    var encResult = encryptData(fileResponse.bodyBytes);
    log("file encrypted successfully");
    // write the file into directory
    String p = await writeData(encResult,
        '${d.path}/${responseBody.data.attributes.image.data.attributes.name}.aes');
    log("done encrypted successfully writen: $p");
    //* } else {
    //*   log("Can't launch URL.");
    //* }
  }

  ///
  /// Fetches file from directory and decrypts it
  ///
  /// Takes the directory [d] to fetch the file.
  ///

  getNormalFile(Directory d) async {
    // reads all files from path and receives a model
    DecryptModel decryptModel = await readFilesPaths("${d.path}/");

    // decryptts the file
    var plainData = await decryptData(decryptModel.uint8list);

    // rewrites the decrypted file into the directory.
    //* we can perform other tasks instead of rewriting the file to directory

    String p = await writeData(plainData, '${d.path}/${decryptModel.fileName}');

    log("file decrypted successfully: $p");
  }

  ///
  /// Encrypts the Uni8List data
  ///
  /// Takes the the data [plainString] to encrypt using [MyEncrypt] model .
  ///

  encryptData(List<int> plainString) {
    log("Encrypting File...");
    log("byte:${plainString.toString().length}");

    final encrypted =
        MyEncrypt.myEncrypter.encryptBytes(plainString, iv: MyEncrypt.myIv);
    return encrypted.bytes;
  }

  ///
  /// Encrypts the Uni8List data
  ///
  /// Takes the the data [plainString] to encrypt using [MyEncrypt] model .
  ///

  decryptData(encData) {
    log("File decryption in progress...");
    Encrypted en = Encrypted(encData);
    return MyEncrypt.myEncrypter.decryptBytes(en, iv: MyEncrypt.myIv);
  }

  ///
  /// Encrypts the Uni8List data
  ///
  /// Takes the the data [plainString] to encrypt using [MyEncrypt] model .
  ///

  Future<Uint8List> readDataFromPath(fileNameWithPath) async {
    log("Reading data...");
    File f = File(fileNameWithPath);
    return await f.readAsBytes();
  }

  ///
  /// reads all the files from the Directory, reads the file paths
  /// and returns file as [Bytes] to decrypt
  ///* initially we tested for single file, thus the implementaion is for a single file
  ///

  Future<DecryptModel> readFilesPaths(path) async {
    //fetch all files from given path
    List<FileSystemEntity> file = Directory(path).listSync();

    //!As there are only 1 file at the moment
    // fetching file Byte
    var uni8list = await readDataFromPath(file.first.path);

    var pathSplit = file.first.path.split('MyEncFolder/');
    var fileName = pathSplit[1].split('.aes');

    // returning a DecryptModel containing file as bytes with file name.

    return DecryptModel(uni8list, fileName[0]);
  }

  ///
  /// writes the data into the directory path
  ///
  /// takes Uni8List data [dataToWrite] to write into the path [fileNameWithPath]
  ///

  Future<String> writeData(
      List<int> dataToWrite, String fileNameWithPath) async {
    log("Writing Data...");
    File f = File(fileNameWithPath);
    await f.writeAsBytes(dataToWrite);
    return f.absolute.toString();
  }

  ///
  /// get application directory.
  ///
  /// encrypted files won't be visibile in this directory
  ///

  Future<Directory> get getAppDir async {
    final appDocDir = await getApplicationDocumentsDirectory();
    return appDocDir;
  }

  ///
  /// gets visible directory.
  ///

  Future<Directory> get getExternalVisibleDir async {
    if (await Directory('/storage/emulated/0/MyEncFolder').exists()) {
      final externalDir = Directory('/storage/emulated/0/MyEncFolder');
      return externalDir;
    } else {
      await Directory('/storage/emulated/0/MyEncFolder')
          .create(recursive: true);
      final externalDir = Directory('/storage/emulated/0/MyEncFolder');
      return externalDir;
    }
  }
}
