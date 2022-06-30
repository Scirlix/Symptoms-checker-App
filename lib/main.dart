import 'package:flutter/material.dart';
import 'acceptance.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diagnose: Symptoms Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Diagnose: Symptoms Checker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Icon(
                  Icons.health_and_safety,
                  size: 120,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Diagnose",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 30),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Diagnose is a symptoms checker ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                Text(
                  "which the result will give:  ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(width: 50),
                    Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                    Text(
                      "Possible causes of your symptoms.",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 50),
                    Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                    Text(
                      "Recommendations on what to do next.",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Image(
                  image: AssetImage("assets/images/doctor.png"),
                  width: 300,
                  height: 220,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Acceptance()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white, elevation: 0),
                      child: const Text('Get Started',
                          style: TextStyle(
                              color: Color.fromARGB(255, 87, 80, 217),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
