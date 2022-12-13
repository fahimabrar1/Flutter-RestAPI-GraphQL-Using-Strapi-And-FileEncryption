import 'package:flutter/material.dart';
import 'package:strapy_flutter/Api%20Testing/graphql.dart';
import 'package:strapy_flutter/Api%20Testing/rest_api.dart';

///<summary>
///
///  This Page allows to navigate to different routes to test
///  Different types or API calls.
///
///</summary>
class ApiLandingPage extends StatelessWidget {
  const ApiLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api from Strapi"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => navigateTo(context, const HomeRestApi()),
                child: const Text("Rest Api")),
            ElevatedButton(
                onPressed: () => navigateTo(context, const HomeGraphQL()),
                child: const Text("Graph QL")),
          ],
        ),
      ),
    );
  }

  ///<summary>
  ///
  /// navigateTo allows to navigate to different Pages.
  ///
  ///</summary>
  void navigateTo(BuildContext context, Widget destination) {
    Navigator.push(
        context, MaterialPageRoute(builder: (builder) => destination));
  }
}
