import 'package:ezcountries/models/country.dart';
import 'package:ezcountries/services/graphql_config.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ApiService {
  static final httpLink =
      HttpLink("https://countries.trevorblades.com/graphql");

  static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
      link: httpLink,
    ),
  );

  Future<Country?> getCountryDetail(String country) async {
    String getCountryDetail = '''
      query Query {
        country(code: "$country") {
          name
          code
          native
          phone
          emoji
          emojiU
          states {
              name
              code
            }
          continent {
              name
              }
            }
      }
      ''';

    GraphQLClient client = GraphQLConfiguration().clientToQuery();

    Country countryResult;
    try {
      QueryResult queryResult = await client.query(
        QueryOptions(
          document: gql(getCountryDetail),
        ),
      );
      // print(queryResult);
      if (queryResult.data!['country'] != null) {
        countryResult = Country.fromJson(queryResult.data!['country']);
        return countryResult;
      } else {
        return null;
        // throw Exception('Invalid country code');
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }

    // return countryResult;
  }
}
