import 'dart:math';

import 'package:flutter/material.dart';
import 'package:translate_app/Services/api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(221, 136, 202, 255)),
      ),
      home: const TranslationPage(),
    );
  }
}


class TranslationPage extends StatefulWidget {
  const TranslationPage({Key? key}) : super(key: key);

  @override
  TranslationPageState createState() => TranslationPageState();
}


class TranslationPageState extends State<TranslationPage> {
  String _inputText = '';
  String _translatedText = '';
  String _selectedLanguage = 'English'; // Default language

  final List<Map<String, String>> languages = [
    { 'id': 'German', 'text': 'Alemán' },
    { 'id': 'Arabic', 'text': 'Árabe' },
    { 'id': 'Bengali', 'text': 'Bengalí' },
    { 'id': 'French', 'text': 'Francés' },
    { 'id': 'Hindi', 'text': 'Hindi' },
    { 'id': 'English', 'text': 'Inglés' },
    { 'id': 'Japanese', 'text': 'Japonés' },
    { 'id': 'Mandarin', 'text': 'Mandarín' },
    { 'id': 'Portuguese', 'text': 'Portugués' },
    { 'id': 'Russian', 'text': 'Ruso' },
    { 'id': 'Chinese', 'text': 'Chino' },
    { 'id': 'Korean', 'text': 'Coreano' },
    { 'id': 'Dutch', 'text': 'Holandés' },
    { 'id': 'Italian', 'text': 'Italiano' },
    { 'id': 'Polish', 'text': 'Polaco' },
    { 'id': 'Swedish', 'text': 'Sueco' },
    { 'id': 'Norwegian', 'text': 'Noruego' },
    { 'id': 'Danish', 'text': 'Danés' },
    { 'id': 'Finnish', 'text': 'Finés' },
    { 'id': 'Greek', 'text': 'Griego' },
    { 'id': 'Hebrew', 'text': 'Hebreo' },
    { 'id': 'Thai', 'text': 'Tailandés' },
    { 'id': 'Indonesian', 'text': 'Indonesio' },
    { 'id': 'Vietnamese', 'text': 'Vietnamita' },
    { 'id': 'Malay', 'text': 'Malayo' },
    { 'id': 'Tagalog', 'text': 'Tagalo' },
    { 'id': 'Urdu', 'text': 'Urdu' },
    { 'id': 'Tamil', 'text': 'Tamil' },
    { 'id': 'Telugu', 'text': 'Telugu' },
    { 'id': 'Kannada', 'text': 'Kannada' }
  ];

  void _translateText() async {
    try {
      final translatedText = await translateText(_inputText, _selectedLanguage);
      setState(() {
        _translatedText = translatedText;
      });
    } catch (e) {
      // Manejar cualquier error aquí
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 202, 202),
      appBar: AppBar(
        title: const Text('TranslateTo'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          // constraints: BoxConstraints(minHeight: 200),
          width: 350, // Define width for the container
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 46, 46, 48),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey[700]!), // Dark gray border
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCustomDropdownButtonFormField(),
              const SizedBox(height: 16),
              Container(
                constraints: const BoxConstraints(minHeight: 50), // Set minimum height for the container
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 226, 226, 226), // Light gray background color
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'Introducir texto a traducir',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _inputText = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _translateText,
                child: const Text('Traducir'),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(minHeight: 50), // Set minimum height for the container
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 226, 226, 226), // Light gray background color
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _translatedText,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomDropdownButtonFormField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 226, 226, 226), // Light gray background color
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedLanguage,
        items: languages.map((Map<String, String> language) {
          return DropdownMenuItem<String>(
            value: language['id'],
            child: Text(
              language['text']!,
              style: const TextStyle(
                color: Colors.black, // Default color for unselected items
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedLanguage = value!;
          });
        },
        decoration: const InputDecoration(
          labelText: 'Seleccionar Idioma',
          border: InputBorder.none,
        ),
        style: const TextStyle(color: Colors.white), // Color for selected item
      ),
    );
  }
}
// class TranslationPage extends StatefulWidget {
//   const TranslationPage({Key? key}) : super(key: key);

//   @override
//   _TranslationPageState createState() => _TranslationPageState();
// }

// class _TranslationPageState extends State<TranslationPage> {
//   String _inputText = '';
//   String _translatedText = '';
//   String _selectedLanguage = 'English'; // Default language

//   final Map<String, String> _languageCodes = {
//     'German': 'de',
//     'Arabic': 'ar',
//     'Bengali': 'bn',
//     'French': 'fr',
//     'Hindi': 'hi',
//     'English': 'en',
//     'Japanese': 'ja',
//     'Mandarin': 'zh',
//     'Portuguese': 'pt',
//     'Russian': 'ru',
//     'Chinese': 'zh',
//     'Korean': 'ko',
//     'Dutch': 'nl',
//     'Italian': 'it',
//     'Polish': 'pl',
//     'Swedish': 'sv',
//     'Norwegian': 'no',
//     'Danish': 'da',
//     'Finnish': 'fi',
//     'Greek': 'el',
//     'Hebrew': 'he',
//     'Thai': 'th',
//     'Indonesian': 'id',
//     'Vietnamese': 'vi',
//     'Malay': 'ms',
//     'Tagalog': 'tl',
//     'Urdu': 'ur',
//     'Tamil': 'ta',
//     'Telugu': 'te',
//     'Kannada': 'kn'
//   };

//   void _translateText() {
//     setState(() {
//       // Perform translation here
//       // For now, simulate translation by converting input text to lowercase
//       _translatedText = _inputText.toLowerCase();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 242, 242, 242),
//       appBar: AppBar(
//         title: const Text('Translate Text'),
//       ),
//       body: Center(
//         child: Container(
//           width: 350, // Define width for the container
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: const Color.fromARGB(255, 42, 45, 53),
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: Colors.grey[700]!), // Dark gray border
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _buildCustomDropdownButtonFormField(),
//               const SizedBox(height: 16),
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 176, 176, 176), // Light gray background color
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: TextField(
//                   keyboardType: TextInputType.multiline,
//                   maxLines: null,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Text to Translate',
//                     border: InputBorder.none,
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       _inputText = value;
//                     });
//                   },
//                 ),
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _translateText,
//                 child: const Text('Translate'),
//               ),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 176, 176, 176), // Light gray background color
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: SingleChildScrollView(
//                     child: Text(
//                       _translatedText,
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCustomDropdownButtonFormField() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 226, 226, 226), // Light gray background color
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: DropdownButtonFormField<String>(
//         value: _selectedLanguage,
//         items: _languageCodes.keys.map((String language) {
//           return DropdownMenuItem<String>(
//             value: language,
//             child: Text(
//               language,
//               style: const TextStyle(
//                 color: Colors.black, // Default color for unselected items
//               ),
//             ),
//           );
//         }).toList(),
//         onChanged: (value) {
//           setState(() {
//             _selectedLanguage = value!;
//           });
//         },
//         decoration: const InputDecoration(
//           labelText: 'Select Language',
//           border: InputBorder.none,
//         ),
//         style: const TextStyle(color: Colors.white), // Color for selected item
//       ),
//     );
//   }
// }
