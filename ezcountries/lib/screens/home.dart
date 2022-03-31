import 'package:ezcountries/models/country.dart';
import 'package:ezcountries/screens/country_detail.dart';
import 'package:ezcountries/screens/search_country.dart';
import 'package:ezcountries/services/queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController _scrollController;
  bool _showBackToTopButton = false;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 0) {
            _showBackToTopButton = true;
          } else {
            _showBackToTopButton = false;
          }
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 3),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Country App'),
          elevation: 0,
          backgroundColor: Colors.orange.shade600,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SearchCountry();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: Query(
          options: QueryOptions(
            document: gql(readAllCountries),
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List countries = result.data!['countries'];

            // print(result.data);

            List<Country> countryList = [];

            countries.forEach((country) {
              countryList.add(Country.fromJson(country));
            });
            // print(countryList.length);
            return ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: countryList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(
                      countryList[index].emoji,
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    title: Text(countryList[index].name),
                    subtitle:
                        Text('Continent: ${countryList[index].continent}'),
                    trailing: Text(countryList[index].code),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CountryDetail(country: countryList[index]),
                        ),
                      );
                    },
                  );
                });
          },
        ),
        floatingActionButton: _showBackToTopButton
            ? FloatingActionButton(
                onPressed: _scrollToTop,
                child: const Icon(Icons.arrow_upward),
                backgroundColor: Colors.orange.shade600,
              )
            : null,
      ),
    );
  }
}
