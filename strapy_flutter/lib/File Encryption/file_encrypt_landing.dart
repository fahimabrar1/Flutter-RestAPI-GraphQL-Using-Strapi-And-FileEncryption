import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:strapy_flutter/File%20Encryption/model/my_app_file_handler.dart';

///
///  This Page presents to download, encrypt and decrypt any file.
///

class FileEncryptLanding extends StatefulWidget {
  const FileEncryptLanding({Key? key}) : super(key: key);

  @override
  State<FileEncryptLanding> createState() => _FileEncryptLandingState();
}

class _FileEncryptLandingState extends State<FileEncryptLanding> {
  bool _isGranted = false; //checks if permission is granted

  //Todo:User your local IP address instead of "localhost"
  //e.g. : http://0.0.0.0:1337/graphql/
  final String host = "http://localhost:1337";

  final String api = "/api/images/1?populate=*";
  // "?populate=*" helps to fetch the file data in strapi v4.
  // without it we cannot fetch file information other than creation data.

  final myAppFileHandler = MyAppFileHandler();
  @override
  Widget build(BuildContext context) {
    requestStoragePermission();
    return Scaffold(
      appBar: AppBar(
        title: const Text("File Encryption"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Download & Encrypt"),
              onPressed: () async {
                if (_isGranted) {
                  ///    we can see all kinds of files if we use this getExternalVisibleDir Directory.
                  ///   user and others can manipulate it via file managers and other sourcese

                  Directory d = await myAppFileHandler.getExternalVisibleDir;

                  ///  To keep the files hidden from directory we should use Application Directory above (Recomanded).
                  ///  You will not able to view Encrypted files and decrepted files if you use Application Directory

                  // Directory d = await getAppDir;

                  /// we pass host,api and directory to download and encrypt the file in device.

                  myAppFileHandler.downloadAndCreate(host, api, d);
                } else {
                  log("No permission granted.");
                  requestStoragePermission();
                }
              },
            ),
            ElevatedButton(
              child: const Text("Decrypt File"),
              onPressed: () async {
                if (_isGranted) {
                  ///    we can see all kinds of files if we use this getExternalVisibleDir Directory.
                  ///   user and others can manipulate it via file managers and other sourcese

                  Directory d = await myAppFileHandler.getExternalVisibleDir;

                  ///  To keep the files hidden from directory we should use Application Directory above (Recomanded).
                  ///  You will not able to view Encrypted files and decrepted files if you use Application Directory

                  // Directory d = await getAppDir;

                  /// we pass host,api and directory to download and encrypt the file in device.

                  myAppFileHandler.getNormalFile(d);
                } else {
                  log("No permission granted.");
                  requestStoragePermission();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  requestStoragePermission() async {
    if (!await Permission.storage.isGranted &&
        !await Permission.manageExternalStorage.isGranted) {
      PermissionStatus result = await Permission.storage.request();
      PermissionStatus result1 =
          await Permission.manageExternalStorage.request();
      if (result.isGranted && result1.isGranted) {
        setState(() {
          _isGranted = true;
        });
      } else {
        setState(() {
          _isGranted = false;
        });
      }
    }
  }
}
