import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:learn_numbers/models/country.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:learn_numbers/models/globals.dart' as globals;

import 'main_screen.dart';

class ChoiseLanguageScreen extends StatefulWidget {
  const ChoiseLanguageScreen({super.key});

  @override
  State<ChoiseLanguageScreen> createState() => _ChoiseLanguageScreenState();
}

class _ChoiseLanguageScreenState extends State<ChoiseLanguageScreen> {
  int _progress = 0;
  bool _isElevated = false;
  List<CountryData> countries = CountryData.getCounties();
  List<DropdownMenuItem<CountryData>> dropdownMenuItems = [];
  CountryData? _selectedCompany;
  String selectedDictionary = '';

  @override
  void initState() {
    dropdownMenuItems = buildDropdownMenuItems(countries);
    _selectedCompany = dropdownMenuItems[3].value;
    selectedDictionary = '';
    super.initState();
  }

  void parsingJSON() async {
    bool skipChoiseLanguage = false;
    // final prefs = await SharedPreferences.getInstance();
    // final bool? selectedLanguage = prefs.getBool('selectedLanguage');
    // if (selectedLanguage != null) {
    //   skipChoiseLanguage = selectedLanguage;
    // }
    skipChoiseLanguage = true;
    var jsonText = await rootBundle.loadString('assets/json/tr.json');
    Map<String, dynamic> data = json.decode(jsonText);
    data.forEach((key, value) {
      globals.sortingMap.putIfAbsent(int.parse(key), () => value.toString());
    });
    if (globals.sortingMap.isNotEmpty) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const MainScreen(
                    title: 'Turkish',
                  )),
          (Route route) => false);
      await Future.delayed(const Duration(seconds: 1));
      FlutterNativeSplash.remove();
    } else {
      await Future.delayed(const Duration(seconds: 2));
      FlutterNativeSplash.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    parsingJSON();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Text('Selected: ${_selectedCompany!.name}'),

            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: DropdownButton(
                // value: _selectedCompany!,
                // items: dropdownMenuItems,
                items: dropdownMenuItems,
                onChanged: onChangeDropdownItem(_selectedCompany!),
              ),
            ),
            // ),
            const SizedBox(
              height: 150.0,
            ),
            // GestureDetector(
            //   onTap: () async {
            //     setState(() {
            //       _isElevated = !_isElevated;
            //     });
            //   },
            //   child: AnimatedContainer(
            //       duration: const Duration(microseconds: 300),
            //       height: 80,
            //       width: 200,
            //       decoration: BoxDecoration(
            //         color: Colors.grey[200],
            //         borderRadius: BorderRadius.circular(50),
            //         boxShadow: _isElevated
            //             ? [
            //                 BoxShadow(
            //                   color: Colors.grey.shade500,
            //                   spreadRadius: 1,
            //                   blurRadius: 8,
            //                   offset: const Offset(4, 4),
            //                 ),
            //                 const BoxShadow(
            //                   color: Colors.white,
            //                   spreadRadius: 2,
            //                   blurRadius: 8,
            //                   offset: Offset(-4, -4),
            //                 ),
            //               ]
            //             : const [
            //                 BoxShadow(
            //                   offset: Offset(-4, -4),
            //                   blurRadius: 8,
            //                   color: Colors.white,
            //                   inset: true,
            //                 ),
            //                 BoxShadow(
            //                   offset: Offset(4, 4),
            //                   blurRadius: 8,
            //                   color: Color(0xFFBEBEBE),
            //                   inset: true,
            //                 )
            //               ],
            //       )),
            // ),
            // Expanded(
            //   child: Align(
            //     alignment: Alignment.center,
            //     child: _progress == 0
            //         ? GestureDetector(
            //             onTap: () async {
            //               setState(() {
            //                 _isElevated = !_isElevated;
            //               });
            //               // loadJsonData();
            //             },
            //             child: Container(
            //               height: 50.0,
            //               width: 50.0,
            //               decoration: BoxDecoration(
            //                 color: Colors.grey[200],
            //                 borderRadius: BorderRadius.circular(25),
            //                 image: const DecorationImage(
            //                   image: Svg('assets/images/download.svg',
            //                       size: Size(25.0, 25.0), color: Colors.black),
            //                 ),
            //                 boxShadow: [
            //                   BoxShadow(
            //                     color: Colors.grey.shade500,
            //                     spreadRadius: 1,
            //                     blurRadius: 8,
            //                     offset: const Offset(4, 4),
            //                   ),
            //                   const BoxShadow(
            //                     color: Colors.white,
            //                     spreadRadius: 2,
            //                     blurRadius: 8,
            //                     offset: Offset(-4, -4),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           )
            //         : CircularPercentIndicator(
            //             radius: 60.0,
            //             lineWidth: 15.0,
            //             percent: _progress % 1,
            //             animation: false,
            //             animationDuration: 1500,
            //             center: Text(
            //               '${_progress % 1} %',
            //               style: const TextStyle(fontSize: 20.0),
            //             ),
            //             progressColor: Colors.amber[900],
            //           ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 50,
            // ),
          ],
        ),
      ),
    );
  }

  // Future<void> loadJsonData() async {
  //   var jsonText = await rootBundle.loadString(selectedDictionary);
  //   Map<String, dynamic> data = json.decode(jsonText);
  //   data.forEach((key, value) {
  //     globals.numericMap.putIfAbsent(key, () => value);
  //   });
  //   // Navigator.of(context).pushAndRemoveUntil(
  //   //                           MaterialPageRoute(
  //   //                               builder: (context) =>
  //   //                                   const MainScreen(title: 'Turkish'));
  // }

  onChangeDropdownItem(CountryData selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
      // selectedDictionary = selectedCompany.dictionary;
    });
  }

  List<DropdownMenuItem<CountryData>> buildDropdownMenuItems(List counties) {
    List<DropdownMenuItem<CountryData>> items = [];
    for (CountryData country in counties) {
      items.add(
        DropdownMenuItem(
          value: country,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  country.images,
                  width: 10,
                  height: 10,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(country.name)
              ],
            ),
          ),
        ),
      );
    }
    return items;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
