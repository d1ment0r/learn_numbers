class CountryData {
  int id;
  String name;
  String images;
  String dictionary = '';

  CountryData(this.id, this.name, this.images, this.dictionary);

// https://cloud.google.com/translate/docs/languages
  static List<CountryData> getCounties() {
    return <CountryData>[
      CountryData(
          1, 'English', 'assets/images/flags/us.png', 'assets/json/en.json'),
      CountryData(
          2, 'Malay', 'assets/images/flags/ms.png', 'assets/json/ms.json'),
      CountryData(
          3, 'French', 'assets/images/flags/fr.png', 'assets/json/fr.json'),
      CountryData(
          4, 'Turkish', 'assets/images/flags/tr.png', 'assets/json/tr.json'),
    ];
  }
}
