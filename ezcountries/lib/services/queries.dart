String readAllCountries = '''
      query Query {
        countries {
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
