import 'package:flutter/material.dart';

import 'package:projet_tuto/widgets/my_app_bar.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic page structure
    // (and its own Material surface).
    return Scaffold(
      // Column is a vertical, linear layout.
      body: Column(
        children: [
          MyAppBar(
            title: Text(
              'Godoto lo',
              style:
                  Theme.of(context) //
                      .primaryTextTheme
                      .titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          // const Expanded(child: Center(child: Text('Hello, world!'))),
          const Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text('Hello, world!'),
            ),
          ),
        ],
      ),
    );
  }
}
