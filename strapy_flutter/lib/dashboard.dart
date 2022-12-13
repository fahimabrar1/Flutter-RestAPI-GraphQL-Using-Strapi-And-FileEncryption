import 'package:flutter/material.dart';
import 'package:strapy_flutter/Api%20Testing/api_landing.dart';
import 'package:strapy_flutter/File%20Encryption/file_encrypt_landing.dart';

///
/// Allows to navigate and test both Api and File Encryption System
///

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => navigateTo(context, const ApiLandingPage()),
              child: const Text("Api Testings"),
            ),
            ElevatedButton(
              onPressed: () => navigateTo(context, const FileEncryptLanding()),
              child: const Text("File Encrypt"),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// navigateTo allows to navigate to different Pages.
  ///
  void navigateTo(BuildContext context, Widget destination) {
    Navigator.push(
        context, MaterialPageRoute(builder: (builder) => destination));
  }
}
