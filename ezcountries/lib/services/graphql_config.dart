import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfiguration {
  GraphQLClient clientToQuery() {
    final httpLink = HttpLink("https://countries.trevorblades.com/graphql");

    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    );
  }
}
