import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _fileContents = '';
  String _imageName = '';
  List<String> imageList = [
    "Assets/pexels-bao-dang-3700369.jpg",
    "Assets/pexels-david-skyrius-2129796.jpg",
    "Assets/pexels-eberhard-grossgasteiger-2098427.jpg",
    "Assets/pexels-guilherme-rossi-1668928.jpg",
    "Assets/pexels-irina-iriser-673857.jpg",
    "Assets/pexels-karolina-grabowska-4622893.jpg"
        "Assets/pexels-leica-palma-19409668.jpg",
    "Assets/pexels-pixabay-326231.jpg",
    "Assets/pexels-pixabay-358457.jpg",
    "Assets/pexels-thanh-lâm-19621565.jpg",
    "Assets/pexels-พี่อ๋อย-กิน-เที่ยว-ถ่าย-สอน-19611068.jpg"
  ];
  @override
  void initState() {
    super.initState();
    loadAsset();
  }

  Future<void> loadAsset() async {
    try {
      String fileText = await rootBundle.loadString('Assets/quotes.txt');
      String imageFile = imageList[Random().nextInt(imageList.length - 1)];
      setState(() {
        _fileContents = fileText
            .split('\n')[Random().nextInt(fileText.split('\n').length - 1)];
        _imageName = imageFile;
      });
    } catch (e) {
      print('Error loading asset: $e');
      setState(() {
        _fileContents = 'Error: Unable to fetch a quote';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 9,
        onPressed: (() {
          loadAsset();
        }),
        backgroundColor: Colors.teal,
        child: Icon(
          Icons.replay_outlined,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color(0xff121212),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(_imageName),
                opacity: 0.3,
              ),
            ),
          ),
          GestureDetector(
            onDoubleTap: () {},
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _fileContents.split("-")[0],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "- " + _fileContents.split("-")[1],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
