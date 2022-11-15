// import 'dart:convert';
// import 'dart:developer' as developer;
// import 'package:learn_numbers/models/country.dart';
// import 'package:learn_numbers/models/globals.dart' as globals;
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:flutter/material.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';

// class ChoiseLanguageScreen extends StatefulWidget {
//   const ChoiseLanguageScreen({super.key});

//   @override
//   State<ChoiseLanguageScreen> createState() => _ChoiseLanguageScreenState();
// }

// class _ChoiseLanguageScreenState extends State<ChoiseLanguageScreen> {
//   int _progress = 0;
//   List<CountryData> countries = CountryData.getCounties();
//   List<DropdownMenuItem<CountryData>> dropdownMenuItems = [];
//   CountryData? _selectedCompany;
//   String selectedDictionary = '';

//   @override
//   void initState() {
//     dropdownMenuItems = buildDropdownMenuItems(countries);
//     _selectedCompany = dropdownMenuItems[3].value;
//     selectedDictionary = '';
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body: Center(
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 150,
//             ),
//             Text('Selected: ${_selectedCompany!.name}'),
//             Padding(
//               padding: const EdgeInsets.only(top: 40.0),
//               child: DropdownButton(
//                 value: _selectedCompany!,
//                 items: dropdownMenuItems,
//                 // items: CountryData.getCounties().map((CountryData)),
//                 onChanged: onChangeDropdownItem(_selectedCompany!),
//               ),
//             ),
//             // ),
//             const SizedBox(
//               height: 150.0,
//             ),
//             Expanded(
//               child: Align(
//                 alignment: Alignment.center,
//                 child: _progress == 0
//                     ? GestureDetector(
//                         onTap: () async {
//                           setState(() {
//                             // _progress = 1;
//                           });
//                           loadJsonData();
//                         },
//                         child: Container(
//                           height: 50.0,
//                           width: 50.0,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             borderRadius: BorderRadius.circular(25),
//                             image: const DecorationImage(
//                               image: Svg('assets/images/download.svg',
//                                   size: Size(25.0, 25.0), color: Colors.black),
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.shade500,
//                                 spreadRadius: 1,
//                                 blurRadius: 8,
//                                 offset: const Offset(4, 4),
//                               ),
//                               const BoxShadow(
//                                 color: Colors.white,
//                                 spreadRadius: 2,
//                                 blurRadius: 8,
//                                 offset: Offset(-4, -4),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     : CircularPercentIndicator(
//                         radius: 60.0,
//                         lineWidth: 15.0,
//                         percent: _progress % 1,
//                         animation: false,
//                         animationDuration: 1500,
//                         center: Text(
//                           '${_progress % 1} %',
//                           style: const TextStyle(fontSize: 20.0),
//                         ),
//                         progressColor: Colors.amber[900],
//                       ),
//               ),
//             ),
//             // const SizedBox(
//             //   height: 50,
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> loadJsonData() async {
//     var jsonText = await rootBundle.loadString(selectedDictionary);
//     Map<String, dynamic> data = json.decode(jsonText);
//     data.forEach((key, value) {
//       globals.numericMap.putIfAbsent(key, () => value);
//     });
//     Navigator.of(context).pushAndRemoveUntil(
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       const MainScreen(title: 'Turkish'));
//   }

//   onChangeDropdownItem(CountryData selectedCompany) {
//     setState(() {
//       _selectedCompany = selectedCompany;
//       selectedDictionary = selectedCompany.dictionary;
//     });
//   }

//   List<DropdownMenuItem<CountryData>> buildDropdownMenuItems(List counties) {
//     List<DropdownMenuItem<CountryData>> items = [];
//     for (CountryData country in counties) {
//       items.add(
//         DropdownMenuItem(
//           value: country,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Image.asset(
//                   country.images,
//                   width: 10,
//                   height: 10,
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Text(country.name)
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//     return items;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
