import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/screens/add_athlete_screen.dart';
import 'package:test/screens/scoring_screen.dart';
import 'package:test/providers/get_athletes_provider.dart';
import 'package:test/theme_data.dart';
import 'screens/athletes_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => GetAtlete())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scoring POM',
      theme: themeData(),
      home: const MyHomePage(title: 'Scoring POM'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  int pressedButtonNo = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      pressedButtonNo = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    Athletes(),
    AddAthlete(),
    Scoring(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Power Of Motion'),
        titleTextStyle: TextStyle(
          color: Colors.black.withOpacity(0.8),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.developer_mode_rounded))
        ],
        actionsIconTheme: IconThemeData(color: Colors.black.withOpacity(0.8)),
      ),
      body: Center(child: _pages.elementAt(selectedIndex)),
      bottomNavigationBar: CurvedNavigationBar(
        index: selectedIndex,
        height: 60.0,
        items: <Icon>[
          Icon(FontAwesomeIcons.personRunning,
              color: pressedButtonNo == 0
                  ? Colors.green
                  : Colors.black.withOpacity(0.8)),
          Icon(FontAwesomeIcons.personCirclePlus,
              color: pressedButtonNo == 1
                  ? Colors.green
                  : Colors.black.withOpacity(0.8)),
          Icon(Icons.scoreboard_rounded,
              color: pressedButtonNo == 2
                  ? Colors.green
                  : Colors.black.withOpacity(0.8)),
        ],
        onTap: onItemTapped,
        color: Colors.white,
        animationCurve: Curves.easeInOut,
        backgroundColor: Colors.black.withOpacity(0.8),
      ),
    );
  }

  /*BottomNavigationBar BottomBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded), label: 'Athletes'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt_1_rounded), label: 'Add Athletes'),
        BottomNavigationBarItem(
            icon: Icon(Icons.scoreboard_rounded), label: 'Scoring'),
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
    );
  }*/
}
