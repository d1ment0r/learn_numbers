class CountryData {
  int id;
  String name;
  String images;
  // String dictionary = '';

  CountryData(this.id, this.name, this.images);

// https://cloud.google.com/translate/docs/languages
  static List<CountryData> getCounties() {
    return <CountryData>[
      CountryData(1, 'English', 'assets/images/flags/us.png'),
      CountryData(2, 'Malay', 'assets/images/flags/ms.png'),
      CountryData(3, 'French', 'assets/images/flags/fr.png'),
      CountryData(4, 'Turkish', 'assets/images/flags/tr.png'),
    ];
  }
}
