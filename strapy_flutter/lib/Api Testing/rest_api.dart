import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeRestApi extends StatefulWidget {
  const HomeRestApi({Key? key}) : super(key: key);

  @override
  State<HomeRestApi> createState() => _HomeRestApiState();
}

class _HomeRestApiState extends State<HomeRestApi> {
  late http.Response response;

  bool error = false; //for error status
  bool loading = false; //for data loading status
  bool fetched = false; //for data fetching status

  String errMsg = ""; //to assigning any error message from API/runtime
  late String body; //for data fetching status

  late var apidata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RestApi Fetch Data from Strapi"),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : //if loading == true, show progress indicator
            Container(
                //if there is any error, show error message
                child: error
                    ? Text("Error: $errMsg")
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            ElevatedButton(
                              onPressed: getData,
                              child: const Text(
                                "Fetch Data",
                              ),
                            ),
                            (fetched)
                                ? Text(
                                    body,
                                  )
                                : const SizedBox(),
                          ]),
              ),
      ),
    );
  }

  getData() async {
    setState(() {
      loading = true;
    });

    //Todo: User your local IP address instead of "localhost"
    //e.g. : http://0.0.0.0:1337
    String url = "http://localhost:1337/api/fluttertests";

    http.Response response = await http.get(Uri.parse(url));

    apidata = response.body; //get JSON decoded data from response

    log("body: $apidata"); //printing the JSON received

    if (response.statusCode == 200) {
      //the fetch is successful
      setState(() {
        fetched = true;
        body = apidata;
      });
    } else {
      setState(() {
        error = true;
        errMsg = "Error while fetching data.";
        loading = false;
      });
    }
  }
}
