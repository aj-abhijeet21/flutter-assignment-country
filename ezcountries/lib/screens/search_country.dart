import 'package:ezcountries/screens/country_detail.dart';
import 'package:ezcountries/screens/home.dart';
import 'package:ezcountries/services/api_service.dart';
import 'package:flutter/material.dart';

class SearchCountry extends StatelessWidget {
  const SearchCountry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _textEditingController = TextEditingController();

    void searchCountry() async {
      if (!_formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid country'),
          ),
        );
      }

      var result = await ApiService()
          .getCountryDetail(_textEditingController.text.trim());

      if (result != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CountryDetail(country: result),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid country'),
          ),
        );
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _textEditingController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    hintText: 'Enter a country code',
                    filled: true,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Country name cannot be empty';
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: searchCountry,
                        child: const Text(
                          'Search Country',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.orange.shade600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),
                          );
                        },
                        child: const Text(
                          'Go to Home',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.orange.shade600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
