import 'package:flutter/material.dart';

// <fkit:imports>
// </fkit:imports>

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // <fkit:material_app>
      // </fkit:material_app>
      home: const Scaffold(
        body: Center(
          child: Text('FKIT fixture'),
        ),
      ),
    );
  }
}
