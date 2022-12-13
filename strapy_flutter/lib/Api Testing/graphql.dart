import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeGraphQL extends StatefulWidget {
  const HomeGraphQL({super.key});

  @override
  State<HomeGraphQL> createState() => _HomeGraphQLState();
}

class _HomeGraphQLState extends State<HomeGraphQL> {
  String readRepositories = """
    query document{
    documents {
      data {
        id
        attributes {
          title    
          writer
          
        }
      }
    }
  }
  """;
  String errmsg = "";
  String body = "";

  bool error = false;
  bool loading = false;
  bool fetched = false;
  bool onPress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GraphQL Fetch Data from Strapi"),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onPressFetch,
              child: const Text(
                "Fetch Data",
              ),
            ),
            (onPress) ? gqlWidget() : const SizedBox(),
          ],
        ),
      ),
    );
  }

  void onPressFetch() async {
    setState(() {
      onPress = true;
    });
  }

  Widget gqlWidget() {
    return Query(
      options: QueryOptions(
        document: gql(readRepositories),
      ),
      builder: (
        QueryResult result, {
        VoidCallback? refetch,
        FetchMore? fetchMore,
      }) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return const CircularProgressIndicator();
        }

        List<dynamic> repositories = result.data?["documents"]["data"];
        log("length: ${repositories.length}");
        log("Query Data: ${repositories[0]['attributes']['writer']}");
        log("Query Data: ${repositories[0]['attributes']['writer']}");

        if (repositories.isEmpty) {
          return const Text('No repositories');
        }

        return ListView.builder(
          itemCount: repositories.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(repositories[index]['attributes']['title'] ?? ''),
              subtitle: Text(repositories[index]['attributes']['writer'] ?? ''),
            );
          },
        );
      },
    );
  }
}
